{
  description = "NixOs config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    zen.url = "github:fufexan/zen-browser-flake";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:nix-community/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    helix.url = "github:helix-editor/helix";
    yazi.url = "github:sxyazi/yazi";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    wezterm.url = "github:wez/wezterm/?dir=nix";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;
      packages = forEachSystem (pkgs:
        import ./pkgs { inherit pkgs; }
      );
      formatter = forEachSystem (pkgs:
        pkgs.nixpkgs-fmt
      );
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        X1E3 = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/configuration.nix ];
        };
      };
    };
}
