{ recurseIntoAttrs, callPackage }:

recurseIntoAttrs {

  alpsCore = callPackage ./alpsCore { };

  ct-hyb = callPackage ./ct-hyb { };

  ct-hyb-segment = callPackage ./ct-hyb-segment { };

  maxent = callPackage ./maxent { };

}
