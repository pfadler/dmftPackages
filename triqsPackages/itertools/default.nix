{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
}:

stdenv.mkDerivation rec {
  pname = "itertools";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256:0sr14vdwph4xf8dxz0dk7dchb85yjxd3ac6c91r8jdnd29ysxjpp";
  };

  patches = [ ./itertools.patch ];
  nativeBuildInputs = [ cmake gtest ];

  doCheck = true;

  meta = {
    description = "itertools is a single-header C++ library for writing of various types of range-based for loops";
    homepage = "https://github.com/TRIQS/itertools";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
