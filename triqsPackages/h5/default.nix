{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, gtest
, triqsPackages
, hdf5
, ncurses
, python3Packages
}:

stdenv.mkDerivation rec {
  pname = "h5";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-mLO5+TdUJ85JHO0PG58wvg4lZW96MY3rpEfRC7x5jxw=";
  };

  patches = [
    ./h5.patch
  ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ triqsPackages.cpp2py hdf5 ncurses ];
  propagatedBuildInputs = with python3Packages; [ numpy ];

  doCheck = true;

  meta = {
    description = "h5 is a high-level C++ interface to the hdf5 library";
    homepage = "https://github.com/TRIQS/h5";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
