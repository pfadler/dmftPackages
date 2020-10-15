{ pkgs ? import <nixpkgs> { } }:

with pkgs;

recurseIntoAttrs {

  alpsPackages = callPackage ./alps { };

  nfft = callPackage ./nfft { };

  triqsPackages = callPackage ./triqs { };

}
