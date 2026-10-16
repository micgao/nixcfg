{ inputs, config, pkgs, ... }:

let
  cfg = config.services.hermes-agent;
in
{
  imports = [ inputs.hermes-agent.nixosModules.default ];

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;

    # Root is a tmpfs, so keep all agent state (HERMES_HOME, sessions,
    # memories, skills, workspace) on the persisted subvolume.
    stateDir = "/persist/hermes";

    # Declared below so the account is visibly ours to remove with the module
    createUser = false;
  };

  users.groups.${cfg.group} = { };
  users.users.${cfg.user} = {
    isSystemUser = true;
    group = cfg.group;
    home = cfg.stateDir;
    createHome = true;
    shell = pkgs.bashInteractive;
    # Cron jobs run in transient `systemd-run --user` scopes, which need a
    # user manager for this uid (the module sets this when it creates the user)
    linger = true;
  };

  # Interactive access to the shared state dir for the CLI
  users.users.micgao.extraGroups = [ cfg.group ];

  # With system.nixos-init.enable activation scripts are not run, but the
  # module writes config.yaml, .env and friends from one. Run that script
  # as a unit ordered before the gateway instead.
  systemd.services.hermes-agent-setup = {
    description = "Hermes Agent state setup";
    wantedBy = [ "multi-user.target" ];
    requiredBy = [ "hermes-agent.service" ];
    before = [ "hermes-agent.service" ];
    after = [ "userborn.service" "local-fs.target" ];
    path = with pkgs; [ coreutils findutils gnugrep gnused util-linux ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${config.system.activationScripts."hermes-agent-setup".text}

      # The module's config.yaml merge runs as root and only chmods the result,
      # leaving it root-owned and unreadable for the service user.
      chown ${cfg.user}:${cfg.group} ${cfg.stateDir}/.hermes/config.yaml
    '';
  };
}
