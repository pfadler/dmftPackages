{ recurseIntoAttrs, callPackage }:

recurseIntoAttrs {

  gftools = callPackage ./gftools { };

  libcommute = callPackage ./libcommute { };

  pomerol = callPackage ./pomerol { };

  pomerol2triqs = callPackage ./pomerol2triqs { };

}
