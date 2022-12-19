{
  description = "Packages for DMFT calculations";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    {
      overlays.default = import ./overlay.nix;
    } //
    flake-utils.lib.eachSystem [ "i686-linux" "x86_64-linux" ] (system:
      let
        dmftPackages = import ./. { pkgs = nixpkgs.legacyPackages.${system}; };
      in
      {
        packages = flake-utils.lib.flattenTree dmftPackages;
        legacyPackages = dmftPackages;
        checks = self.packages.${system};
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      });
}
