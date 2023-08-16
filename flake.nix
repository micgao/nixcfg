{
  description = "Nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree/nixpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    joshuto.url = "github:kamiyaa/joshuto";
    hardware.url = "github:nixos/nixos-hardware/master";
    helix.url = "github:helix-editor/helix";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-unfree, home-manager, nix-index-database, hyprland, hyprpicker, hyprpaper, helix, joshuto, ... }@inputs:

  let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
  in
  {
    packages = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in import ./pkgs { inherit pkgs; }
    );
    devShells = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in import ./shell.nix { inherit pkgs; }
    );
    overlays = import ./overlays { inherit inputs; };
    nixosConfigurations = {
      X1E3 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./nixos/configuration.nix ];
      };
    };
  };
}
