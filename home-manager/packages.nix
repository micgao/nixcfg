{ pkgs, inputs, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    packages = with pkgs; [
      qmk
      faugus-launcher
      umu-launcher
      discord
      discord-canary
      lsfg-vk
      lsfg-vk-ui
      viddy
      code-cursor
      opencode
      brave-origin
      rustup
      curlie
      circumflex
      ffmpeg
      fd
      xdg-utils
      skate
      gpg-tui
      playerctl
      mpc
      vlc
      procs
      megacmd
      protonmail-bridge
      keepassxc
      pavucontrol
      obsidian
      jetbrains-toolbox
      feather
      wineWow64Packages.wayland
      rose-pine-hyprcursor
      qobuz-dl
      streamrip
      monero-gui
      monero-cli
      reaper
      inputs.zen.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-devedition-bin
      inputs.hyprshutdown.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.hyprpwcenter.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
