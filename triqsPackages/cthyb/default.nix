{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, cpp2py
, itertools
, mpi
, triqs
, ncurses
, nfft
, openssh
}:

stdenv.mkDerivation rec {
  pname = "cthyb";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256:1jjxlz47bxby2hhjnmgiixm9vvz56yxfmsw8ymqzs64zcx4c08pq";
  };

  patches = [ ./cthyb.patch ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ cpp2py itertools mpi ncurses nfft ];
  propagatedBuildInputs = [ triqs ];

  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Toolbox for Research on Interacting Quantum Systems";
    homepage = "https://triqs.github.io/cthyb/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
