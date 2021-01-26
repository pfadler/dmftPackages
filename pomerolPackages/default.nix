{ recurseIntoAttrs, callPackage }:

recurseIntoAttrs {

  gftools = callPackage ./gftools { };

  pomerol = callPackage ./pomerol { };

  pomerol2triqs = callPackage ./pomerol2triqs { };

}
