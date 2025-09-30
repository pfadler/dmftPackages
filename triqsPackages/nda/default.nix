{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, ncurses
, python3Packages
, openblasCompat
, openssh
}:

stdenv.mkDerivation rec {
  pname = "nda";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-fsNWkxu3cvoOXDVNJkjBaGMlValPvYsGLbb3cNAXmZk=";
  };

  patches = [ ./nda.patch ];
  cmakeFlags = [ "-DBuild_Deps=Never" "-DPythonSupport=ON" ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [
    triqsPackages.h5
    openblasCompat
    ncurses
  ];
  propagatedBuildInputs = [
    python3Packages.numpy
    python3Packages.mako
    python3Packages.scipy
    triqsPackages.itertools
    triqsPackages.cpp2py
    triqsPackages.mpi
  ];

  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "C++ library for multi-dimensional arrays";
    homepage = "https://github.com/TRIQS/nda";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
