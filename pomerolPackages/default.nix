{ recurseIntoAttrs, callPackage, pomerolPackages, python3Packages }:

recurseIntoAttrs {

  gftools = callPackage ./gftools { };

  libcommute = callPackage ./libcommute { };

  pomerol = callPackage ./pomerol { };

  pomerol2triqs = callPackage ./pomerol2triqs { };

  pycommute = python3Packages.callPackage ./pycommute { inherit pomerolPackages; };

}
