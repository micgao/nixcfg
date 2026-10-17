{ config, lib, ... }:

# Opt-in persistence for the tmpfs root, built only from initrd units so it
# works with system.nixos-init and the /etc overlay (no activation scripts).
#
# Every entry lives under /persist and is bind-mounted over its real path in
# the initrd, before switch-root. Sources are created by systemd-tmpfiles in
# the initrd, which has no passwd database, so ownership must be numeric.
let
  cfg = config.persist;
  inherit (lib) mkOption types;

  # tmpfiles runs after initrd-fs.target, so the binds are ordered behind it
  # rather than being part of initrd-fs.target themselves. Ordering only: the
  # tmpfiles unit conflicts with initrd-switch-root.target, so a Requires= on
  # it would unmount the binds right before switch-root.
  tmpfiles = "systemd-tmpfiles-setup-sysroot.service";

  common = {
    options = {
      path = mkOption {
        type = types.strMatching "/.*";
        description = "Absolute path on the running system.";
      };
      mode = mkOption {
        type = types.str;
        default = "0755";
      };
      uid = mkOption {
        type = types.int;
        default = 0;
      };
      gid = mkOption {
        type = types.int;
        default = 0;
      };
    };
  };

  directory = types.submodule [
    common
    {
      options.bind = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Bind the directory over its path. When false it is only created
          under /persist, for consumers that read /persist/... directly.
        '';
      };
    }
  ];

  file = types.submodule [
    common
    {
      options.content = mkOption {
        type = types.str;
        default = "";
        description = "Initial content, written only when the file is first created.";
      };
    }
  ];

  store = path: "/sysroot/persist${path}";
  target = path: "/sysroot${path}";

  mkBind = entry: {
    where = target entry.path;
    what = store entry.path;
    type = "none";
    # x-initrd.mount: an initrd mount, left alone by stage 2 at shutdown.
    options = "bind,x-initrd.mount";
    after = [ tmpfiles ];
    before = [ "initrd.target" ];
    requiredBy = [ "initrd.target" ];
    unitConfig.DefaultDependencies = false;
  };

  owner = entry: {
    inherit (entry) mode;
    user = toString entry.uid;
    group = toString entry.gid;
  };
in
{
  options.persist = {
    directories = mkOption {
      type = types.listOf directory;
      default = [ ];
    };
    files = mkOption {
      type = types.listOf file;
      default = [ ];
    };
  };

  config = {
    assertions = [
      {
        assertion = config.boot.initrd.systemd.enable;
        message = "persist.nix needs boot.initrd.systemd.enable";
      }
      {
        assertion = config.fileSystems."/persist".neededForBoot;
        message = "/persist must be neededForBoot so it is mounted in the initrd";
      }
    ];

    boot.initrd.systemd = {
      tmpfiles.settings.persist =
        # Parents of persisted files, unless a directory entry already covers them.
        lib.listToAttrs (
          map (f: lib.nameValuePair (store (dirOf f.path)) { d.mode = "0755"; }) cfg.files
        )
        // lib.listToAttrs (map (d: lib.nameValuePair (store d.path) { d = owner d; }) cfg.directories)
        // lib.listToAttrs (
          map (f: lib.nameValuePair (store f.path) {
            f = owner f // { argument = f.content; };
          }) cfg.files
        );

      mounts = map mkBind (lib.filter (d: d.bind) cfg.directories ++ cfg.files);
    };
  };
}
