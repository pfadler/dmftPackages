{ recurseIntoAttrs, callPackage }:

recurseIntoAttrs {

  alpsCore = callPackage ./alpsCore { };

  ct-hyb = callPackage ./ct-hyb { };

  ct-hyb-segment = callPackage ./ct-hyb-segment { };

  ct-int = callPackage ./ct-int { };

  maxent = callPackage ./maxent { };

}
