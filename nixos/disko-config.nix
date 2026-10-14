{
  disko.devices = {
    disk = {
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
                  "-f"
                  "-d raid0"
                  "-m raid0"
                  "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S59ANS0N601485A-part2"
                ];
                subvolumes = {
                  "home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                  "var-log" = {
                    mountpoint = "/var/log";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                  "persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                  "root" = {
                    mountpoint = "/root";
                    mountOptions = [ "compress=zstd" "noatime" "ssd" ];
                  };
                };
              };
            };
          };
        };
      };

      # Fast throwaway space for Nix builds and VMs, kept apart from the
      # RAID0 pool. Nothing here is backed up. nofail keeps the system
      # booting if this drive ever dies.
      scratch = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SKHynix_HFS256GD9TNI-L2B0B_CS04N5942136C771T";
        content = {
          type = "gpt";
          partitions = {
            scratch = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "builds" = {
                    mountpoint = "/scratch/builds";
                    mountOptions = [ "noatime" "ssd" "nofail" ];
                  };
                  # libvirt's whole state directory: VM definitions, the
                  # default image pool and networks all survive the tmpfs root.
                  "vms" = {
                    mountpoint = "/var/lib/libvirt";
                    mountOptions = [ "noatime" "ssd" "nofail" ];
                  };
                  "misc" = {
                    mountpoint = "/scratch/misc";
                    mountOptions = [ "noatime" "ssd" "nofail" ];
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
