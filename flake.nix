{
  description = "Packages for DMFT calculations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    {
      overlay = import ./overlay.nix;
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        dmftPackages = import ./. { pkgs = nixpkgs.legacyPackages.${system}; };
      in
      {
        packages = flake-utils.lib.flattenTree dmftPackages;
        legacyPackages = dmftPackages;
        checks = self.packages.${system};
      });
}
