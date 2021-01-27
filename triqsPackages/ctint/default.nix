{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, ncurses
, nfft
, openssh
}:

stdenv.mkDerivation rec {
  pname = "ctint";
  version = "3.0.0";

  src = builtins.fetchGit {
    url = "git+ssh://git@github.com/TRIQS/${pname}.git";
    ref = "refs/tags/${version}";
    rev = "19853f8b6a2bc5f9e32f7318fcd91ccaa5c77a29";
  };

  patches = [ ./ctint.patch ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [
    ncurses
    nfft
    triqsPackages.cpp2py
    triqsPackages.itertools
    triqsPackages.mpi
  ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  UCX_LOG_FILE = "ucx.log";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Continuous-time interaction expansion quantum Monte-Carlo code based on TRIQS";
    homepage = "https://triqs.github.io/ctint/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
