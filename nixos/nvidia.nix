{ lib, ... }: {
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
}
