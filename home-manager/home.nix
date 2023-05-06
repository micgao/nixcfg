{ inputs, lib, config, pkgs, ... }: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "micgao";
    homeDirectory = "/home/micgao";
    packages = with packages; [
      steam
    ];
  };

  programs.neovim.enable = true;
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.firefox.enable = true;
  programs.wezterm.enable = true;
  programs.alacritty.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "22.11";
}
