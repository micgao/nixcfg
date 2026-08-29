{ inputs, lib, config, pkgs, ... }: {
  environment.etc = {
    "nvidia/nvidia-application-profiles-rc.d/50-vram-alloc-fixes.json".text = builtins.toJSON {
      rules = [
        {
          pattern = [ ];
          profile = "No VidMem Reuse";
        }
      ];
    };
  };
}
