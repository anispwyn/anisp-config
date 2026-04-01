{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
  ];
  disko.devices = {
    disk = {
      games = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-MTFDKBA512TFH-1BC1AABHA_UMDMC01J1H3RXJ";
        content = {
          type = "gpt";
          partitions = {
            games = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@Games" = {
                    mountpoint = "/games";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_500GB_23313J804985";
        content = {
          type = "gpt";
          partitions = {
            swap = {
              priority = 1;
              size = "16G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            ESP = {
              priority = 2;
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              priority = 3;
              size = "60%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime" "discard=async" "space_cache=v2"];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime" "discard=async" "space_cache=v2"];
                  };
                  "@Music" = {
                    mountpoint = "/music";
                    mountOptions = ["compress=zstd" "noatime"];
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
