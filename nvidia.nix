{ config, ... }: {
  environment.etc = {
    "nvidia/nvidia-application-profiles-rc.d/50-vram-alloc-fixes.json".text = ''
      {
	      "rules": [{
		      "pattern": {
			      "feature": "cmdline",
			      "matches": "Hyprland"
		      },
		      "profile": "Limit Free Buffer Pool on Hyprland"
	      }],
	      "profiles": [{
		      "name": "Limit Free Buffer Pool on Hyprland",
		      "settings": [{
			      "key": "GLVidHeapReuseRatio",
			      "value": 0
		      }]
	      }]
      }
    '';
  };
  hardware = {
    nvidia = {
      branch = "bleeding_edge";
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "615.71.09";
      #   sha256_64bit = "sha256-zc7tIrvrYSSNGm3qvCWWZz46ZQFpjucayNL9wo87cP4=";
      #   openSha256 = "sha256-3gByMYIwFzRaLdDG+roCEOuKRRJDrljG9AlLnRZTirM=";
      #   settingsSha256 = "sha256-LK1LU8mDkM/XVRKPBtuOZh9nIP/lGFLAJnmasEX8jhg=";
      #   persistencedSha256 = "sha256-qPRb+3d88+2RcpUkoBTbjIaImnQ+jX+/6p1vXcJ5geE=";
      # };
      open = true;
      modesetting.enable = true;
      nvidiaSettings = false;
      videoAcceleration = true;
      moduleParams = {
        nvidia-drm = {
          color_pipeline = 0;
        };
      };
    };
  };
}
