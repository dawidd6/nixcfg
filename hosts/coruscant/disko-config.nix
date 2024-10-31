{
  disk ? "/dev/sda",
  ...
}:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = disk;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              end = "-16G";
              content = {
                type = "luks";
                name = "cryptroot";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
            swap = {
              end = "-0";
              content = {
                type = "luks";
                name = "cryptswap";
                content = {
                  type = "swap";
                };
              };
            };
          };
        };
      };
    };
  };
}
