{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, gcc13
, cmake
, gtest
, fmt
, python3Packages
, boost
, triqsPackages
, fftw
, gmp
, ncurses
, openblasCompat
, openssh
, git
, hdf5
}:

stdenv.mkDerivation rec {
  pname = "triqs";
  version = "3.3.1";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-0It/Xr2ldaQWnlR111Dl+USjRj4cS8Sojscac5bjRzc=";
  };

  patches = [
    ./triqs.patch
  ];
  nativeBuildInputs = [ gcc13 cmake gtest fmt python3Packages.wrapPython triqsPackages.itertools ];
  cmakeFlags = [ "-DCMAKE_SKIP_BUILD_RPATH=OFF" "-DBuild_Deps=Never" ];
  buildInputs = [
    openblasCompat
    git
    hdf5
    fmt
  ];
  pythonPath = with python3Packages; [ numpy matplotlib mpi4py Mako scipy ];
  propagatedBuildInputs = [
    boost
    fftw
    gmp
    triqsPackages.cpp2py
    triqsPackages.h5
    triqsPackages.nda
    triqsPackages.itertools
    triqsPackages.mpi
    triqsPackages.cppdlr
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
