{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, fmt
, python3Packages
, openblasCompat
, hdf5
, mpi
, git
}:

stdenv.mkDerivation rec {
  pname = "cppdlr";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "flatironinstitute";
    repo = pname;
    rev = version;
    sha256 = "sha256-6ZyaIAgg5Ik3IodWVZavclm1LwGLqlYPIplHjZUd8eI=";
  };

  patches = [ ./cppdlr.patch ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  nativeBuildInputs = [ cmake gtest git ];
  buildInputs = [
    hdf5
    mpi
    openblasCompat
    fmt
  ];

  propagatedBuildInputs = [
    triqsPackages.cpp2py
    triqsPackages.h5
    triqsPackages.nda
    triqsPackages.itertools
    triqsPackages.mpi
  ];

  meta = {
    description = "Discrete Lehmann representation of imaginary time Green's functions";
    homepage = "https://github.com/flatironinstitute/cppdlr";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
