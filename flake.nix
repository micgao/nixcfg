{
  description = "NixOs config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-staging.url = "github:nixos/nixpkgs/staging";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix";
    yazi.url = "github:sxyazi/yazi";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [ "x86_64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    packages = forAllSystems (system:
      import ./pkgs nixpkgs.legacyPackages.${system}
    );
    formatter = forAllSystems (system:
      nixpkgs.legacyPackages.${system}.alejandra
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
