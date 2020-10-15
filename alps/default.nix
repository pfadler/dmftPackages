{ newScope, recurseIntoAttrs }:

let

  alpsPackages = recurseIntoAttrs (let

    callPackage = newScope alpsPackages;

  in {

    alpsCore = callPackage ./alpsCore { };

    maxent = callPackage ./maxent { };

  });

in alpsPackages
