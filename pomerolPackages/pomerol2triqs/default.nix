{ stdenv
, fetchFromGitHub
, cmake
, gtest
, boost
, pomerol
, triqsPackages
, ncurses
, openmpi
, openssh
}:

let
  rev = "719e69a23bbee0de69fdae0cacc452227241e06e";
in
stdenv.mkDerivation rec {
  pname = "pomerol2triqs";
  version = "0.5+git20201127.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    inherit rev;
    sha256 = "sha256-i6h8kJzpu7u+SvefZaGZOfNrVgAjUL7h7Svndk9mBNA=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    pomerol
    ncurses
    openmpi
  ] ++ (with triqsPackages; [
    cpp2py
    itertools
    mpi
    triqs
  ]);

  OMPI_MCA_rmaps_base_oversubscribe = "yes";
  checkInputs = [ openssh ];
  doCheck = true;
}
