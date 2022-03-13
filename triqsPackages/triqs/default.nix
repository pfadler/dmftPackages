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
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-1oX84NlTVq1X3K/AwfLLAmMaktLDKeKUW/hObWuXfMs=";
  };

  patches = [ ./triqs.patch ];
  nativeBuildInputs = [ cmake gtest python3Packages.wrapPython ];
  cmakeFlags = [ "-DCMAKE_SKIP_BUILD_RPATH=OFF" "-DBuild_Deps=Never" ];
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
    triqsPackages.nda
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
