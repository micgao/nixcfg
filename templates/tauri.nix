{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };
  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [ (import rust-overlay) ];
          pkgs = import nixpkgs {
            inherit system overlays;
          };
          rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
          libraries = with pkgs; [
            webkitgtk
            gtk3
            cairo
            gdk-pixbuf
            glib
            dbus
            openssl_3
            librsvg
          ];
          nativeBuildInputs = with pkgs; [ rustToolchain pkg-config ];
          buildInputs = with pkgs; [
            openssl
            curl
            wget
            dbus
            openssl_3
            glib
            gtk3
            libsoup
            webkitgtk
            librsvg
          ];
        in
        with pkgs;
        {
          devShells.default = mkShell {
            inherit buildInputs nativeBuildInputs;
            shellHook =
            ''
              export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
            '';
          };
        }
      );
}
