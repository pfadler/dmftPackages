{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, fmt
, python3Packages
, boost
, triqsPackages
, fftw
, gmp
, openblasCompat
, openssh
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
  nativeBuildInputs = [ cmake gtest python3Packages.wrapPython ];
  cmakeFlags = [ "-DCMAKE_SKIP_BUILD_RPATH=OFF" "-DBuild_Deps=Never" ];
  buildInputs = [
    openblasCompat
    fmt
  ];
  pythonPath = with python3Packages; [ numpy matplotlib mpi4py Mako scipy ];
  propagatedBuildInputs = [
    hdf5
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
