{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let

  newScope = extra: lib.callPackageWith (pkgs // extra);

in lib.makeScope newScope (self:
  with self; {

    alpsPackages = callPackage ./alpsPackages { };

    nfft = callPackage ./nfft { };

    triqsPackages = callPackage ./triqsPackages { };

    w2dynamics = callPackage ./w2dynamics { };

  })
