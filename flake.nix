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
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpwcenter = {
      url = "github:hyprwm/hyprpwcenter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlauncher = {
      url = "github:hyprwm/hyprlauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpolkitagent = {
      url = "github:hyprwm/hyprpolkitagent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprqt6engine = {
      url = "github:hyprwm/hyprqt6engine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprshutdown = {
      url = "github:hyprwm/hyprshutdown";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
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
