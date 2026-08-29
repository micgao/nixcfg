{
  description = "NixOs config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default-linux";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:nix-community/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprpwcenter = {
      url = "github:hyprwm/hyprpwcenter";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
    };
    hyprshutdown = {
      url = "github:hyprwm/hyprshutdown";
    };
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    zen = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    helix.url = "github:helix-editor/helix";
    yazi.url = "github:sxyazi/yazi";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    wezterm.url = "github:wez/wezterm/?dir=nix";
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , systems
    , ...
    } @ inputs:
    let
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;
      packages = forEachSystem (pkgs:
        import ./pkgs { inherit pkgs; }
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
