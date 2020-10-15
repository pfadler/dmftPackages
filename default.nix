{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let

  dmftPackages = recurseIntoAttrs (let

    callPackage = newScope dmftPackages;

  in {

    alpsPackages = callPackage ./alps { };

    nfft = callPackage ./nfft { };

    triqsPackages = callPackage ./triqs { };

    w2dynamics = callPackage ./w2dynamics { };

  });

in dmftPackages
