final: prev:
let
  dmftPackages = prev.lib.recurseIntoAttrs (
    let
      callPackage = prev.newScope dmftPackages;
    in
    {
      alpsPackages = callPackage ./alpsPackages { };
      nfft = callPackage ./nfft { };
      triqsPackages = callPackage ./triqsPackages { };
      w2dynamics = callPackage ./w2dynamics { };
    }
  );
in
{ inherit dmftPackages; }
