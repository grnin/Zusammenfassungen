{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    tanki = {
      url = "github:omega-800/tanki";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, tanki, ... }:
    {
      devShells.x86_64-linux.default =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [
              tanki.overlays.typst-mathml
              tanki.overlays.tanki
            ];
          };
        in
        pkgs.mkShellNoCC {
          packages = [ pkgs.tanki-rs pkgs.typst-mathml ];
          PATH = "${pkgs.typst-mathml}/bin:$PATH";

          TYPST_PACKAGE_PATH = "${pkgs.lib.escapeShellArg (
            pkgs.linkFarm "unpublished-typst-packages" {
              "local/tanki/0.0.1" = tanki;
            }
          )}";
        };
    };
}