{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, python3Packages
, boost
, triqsPackages
, fftw
, gmp
, ncurses
, openblasCompat
, openssh
}:

stdenv.mkDerivation rec {
  pname = "triqs";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256:0gf5j4agslcyqrbyp9vwp88mpf2jpv0smmjh0b6jrwn54v8jpw08";
  };

  patches = [ ./triqs.patch ./tail_issues.patch ];
  nativeBuildInputs = [ cmake gtest python3Packages.wrapPython ];
  buildInputs = [
    boost
    fftw
    gmp
    ncurses
    openblasCompat
  ];
  pythonPath = with python3Packages; [ numpy matplotlib mpi4py Mako scipy ];
  propagatedBuildInputs = [
    triqsPackages.cpp2py
    triqsPackages.h5
    triqsPackages.itertools
    triqsPackages.mpi
  ] ++ pythonPath;
  postFixup = "wrapPythonPrograms";

  UCX_LOG_FILE = "ucx.log";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Toolbox for Research on Interacting Quantum Systems";
    homepage = "https://triqs.github.io/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
