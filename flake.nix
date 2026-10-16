{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    wezterm.url = "github:wez/wezterm/?dir=nix";
    ghostty.url = "github:ghostty-org/ghostty";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    yazi.url = "github:sxyazi/yazi";
    fsel.url = "github:Mjoyufull/fsel";
    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    claude-desktop.url = "github:patrickjaja/claude-desktop-extra";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    systems = [ "x86_64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }));
  in {
    overlays.default = final: prev: import ./pkgs {
      inherit (prev) lib;
      inherit (final) callPackage;
    };
    packages = forAllSystems (pkgs: import ./pkgs { inherit (pkgs) lib callPackage; });
    nixosConfigurations.XDDD = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/configuration.nix
      ];
    };
  };
}
