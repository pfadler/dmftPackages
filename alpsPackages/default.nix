{ recurseIntoAttrs, callPackage }:

recurseIntoAttrs {

  alpsCore = callPackage ./alpsCore { };

  maxent = callPackage ./maxent { };

}
