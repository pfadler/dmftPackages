{ lib, newScope, recurseIntoAttrs }:

lib.makeScope newScope (self:
  with self;
  recurseIntoAttrs {

    gftools = callPackage ./gftools { };

    pomerol = callPackage ./pomerol { };

    pomerol2triqs = callPackage ./pomerol2triqs { };

  })
