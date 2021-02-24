{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, boost
, pomerolPackages
, triqsPackages
, ncurses
, mpi
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
  cmakeFlags = [ "-DCMAKE_CXX_FLAGS=-fconcepts" ];
  buildInputs = [
    mpi
    ncurses
    pomerolPackages.pomerol
  ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  OMPI_MCA_rmaps_base_oversubscribe = "yes";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Quick and dirty TRIQS wrapper around the Pomerol exact diagonalization library";
    homepage = "https://github.com/krivenko/pomerol2triqs";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
