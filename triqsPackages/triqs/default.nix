{ stdenv, fetchFromGitHub, cmake, gtest, python3Packages, boost, cpp2py, fftw
, gmp, h5, itertools, mpi, ncurses, openblasCompat, openssh }:

stdenv.mkDerivation rec {
  pname = "triqs";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256:0gf5j4agslcyqrbyp9vwp88mpf2jpv0smmjh0b6jrwn54v8jpw08";
  };

  patches = [ ./triqs.patch ];
  nativeBuildInputs = [ cmake gtest python3Packages.wrapPython ];
  buildInputs = [ boost cpp2py fftw gmp itertools mpi ncurses openblasCompat ];
  pythonPath = with python3Packages; [ numpy matplotlib mpi4py Mako scipy ];
  propagatedBuildInputs = [ h5 ] ++ pythonPath;
  postFixup = "wrapPythonPrograms";

  UCX_LOG_FILE = "ucx.log";
  checkInputs = [ openssh ];
  doCheck = true;
}
