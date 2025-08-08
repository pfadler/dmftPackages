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
    triqsPackages.cpp2py
    triqsPackages.itertools
    triqsPackages.h5
    triqsPackages.mpi
    openblasCompat
    ncurses
  ];
  propagatedBuildInputs = with python3Packages; [ numpy mako scipy ];

  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "C++ library for multi-dimensional arrays";
    homepage = "https://github.com/TRIQS/nda";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
