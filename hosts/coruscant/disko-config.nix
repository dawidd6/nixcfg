{
  disko = {
    memSize = 4096;
    devices = {
      disk = {
        main = {
          imageSize = "64G";
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
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
            };
          };
        };
      };
    };
  };
}
