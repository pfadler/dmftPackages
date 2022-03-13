{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
}:

stdenv.mkDerivation rec {
  pname = "itertools";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-01PXIrypIQZo1X3UHKjVyZ230AS8LfGhvJunD/A3ttQ=";
  };

  patches = [ ./itertools.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];

  doCheck = true;

  meta = {
    description = "itertools is a single-header C++ library for writing of various types of range-based for loops";
    homepage = "https://github.com/TRIQS/itertools";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
