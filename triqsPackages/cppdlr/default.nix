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
}:

stdenv.mkDerivation rec {
  pname = "cppdlr";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "flatironinstitute";
    repo = pname;
    rev = version;
    sha256 = "sha256-PxZtJifJotQtON+bEVGelXl/G9jxxfV5WmD6UJlhtLU=";
  };

  patches = [ ./cppdlr.patch ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [
    hdf5
    mpi
    openblasCompat
    fmt
  ];

  propagatedBuildInputs = [
    triqsPackages.h5
    triqsPackages.nda
  ];

  doCheck = true;

  meta = {
    description = "Discrete Lehmann representation of imaginary time Green's functions";
    homepage = "https://github.com/flatironinstitute/cppdlr";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ pfadler ];
  };
}
