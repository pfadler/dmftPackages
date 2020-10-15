{ newScope, recurseIntoAttrs }:

let

  triqsPackages = recurseIntoAttrs (let

    callPackage = newScope triqsPackages;

  in {

    cpp2py = callPackage ./cpp2py { };

    h5 = callPackage ./h5 { };

    itertools = callPackage ./itertools { };

    mpi = callPackage ./mpi { };

    triqs = callPackage ./triqs { };

  });

in triqsPackages
