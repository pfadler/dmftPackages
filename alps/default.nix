{ lib, newScope, recurseIntoAttrs }:

lib.makeScope newScope (self: with self; recurseIntoAttrs {

  alpsCore = callPackage ./alpsCore { };

  maxent = callPackage ./maxent { };

})
