{
  disko.devices = {
    disk = {
      # "disk1" sorts before "disk2" alphabetically -> disko creates this one first.
      disk1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S59ANS0N601485A";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            # "root" sorts after "esp" -> becomes partition 2.
            # Left with NO content on purpose: this partition is raw space that
            # becomes the 2nd member of the btrfs RAID0 pool defined on disk2 below.
            root = {
              size = "100%";
            };
          };
        };
      };

      disk2 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S6S1NS0T410131D";
        content = {
          type = "gpt";
          partitions = {
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"        # force, in case old filesystem signatures linger
                  "-d raid0"  # data striped across both disks
                  "-m raid0"  # metadata striped too (max performance, no safety net)
                  "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S59ANS0N601485A-part2"
                ];
                subvolumes = {
                  # NOTE: no "/" subvolume here on purpose — root is tmpfs,
                  # declared separately in ephemeral-root.nix (not disk-backed).
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                  "@var-log" = {
                    mountpoint = "/var/log";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                  "@root" = {
                    mountpoint = "/root";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
