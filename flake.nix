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
    preservation.url = "github:nix-community/preservation";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.X3D = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
