{ pkgs, inputs, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    packages = with pkgs; [
      qmk
      discordo
      lsfg-vk
      lsfg-vk-ui
      viddy
      streamlink
      code-cursor
      opencode
      inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-devedition-bin
      brave
      inputs.ghostty.packages."${pkgs.stdenv.hostPlatform.system}".default
      rustup
      comma
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
      (wine.override { wineBuild = "wineWow"; wineRelease = "staging"; fontconfigSupport = true; alsaSupport = true; gtkSupport = true; openglSupport = true; dbusSupport = true; openclSupport = true; cursesSupport = true; vaSupport = true; pulseaudioSupport = true; udevSupport = true; vulkanSupport = true; sdlSupport = true; usbSupport = true; waylandSupport = true; embedInstallers = true; })
      qobuz-dl
      streamrip
      monero-gui
      monero-cli
      rose-pine-hyprcursor
      reaper
      inputs.hyprshutdown.packages."${pkgs.stdenv.hostPlatform.system}".default
      inputs.hyprpwcenter.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
  };
}
