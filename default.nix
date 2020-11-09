{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let

  newScope = extra: lib.callPackageWith (pkgs // extra);

in lib.makeScope newScope (self: with self; {

  alpsPackages = callPackage ./alps { };

  nfft = callPackage ./nfft { };

  triqsPackages = callPackage ./triqs { };

  w2dynamics = callPackage ./w2dynamics { };

})
