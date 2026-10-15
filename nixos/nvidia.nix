{ config, ... }: {
  hardware = {
    nvidia = {
      # branch = "bleeding_edge";
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "615.78.08";
        sha256_64bit = "sha256-Pj9t3cLudnoIGFMAr3vjyyhuznZpjS3eNSRZl4LQf/4=";
        openSha256 = "sha256-HBINiOjL0ZJLIAJeNIBYHBnwgUXtNwPPtnFpAI1YwF4=";
        usePersistenced = false;
        useSettings = false;
      };
      open = true;
      modesetting.enable = true;
      nvidiaSettings = false;
      videoAcceleration = true;
      moduleParams = {
        # nvidia-drm = {
        #   color_pipeline = 0;
        # };
      };
    };
  };
}
