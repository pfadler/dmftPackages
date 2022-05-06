{ recurseIntoAttrs, callPackage }:

recurseIntoAttrs {

  alpsCore = callPackage ./alpsCore { };

  ct-hyb = callPackage ./ct-hyb { };

  maxent = callPackage ./maxent { };

}
