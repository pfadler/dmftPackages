{ stdenv, fetchFromGitHub, cmake, gtest }:

stdenv.mkDerivation rec {
  name = "itertools";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = name;
    rev = version;
    sha256 = "sha256:0sr14vdwph4xf8dxz0dk7dchb85yjxd3ac6c91r8jdnd29ysxjpp";
  };

  patches = [ ./itertools.patch ];
  nativeBuildInputs = [ cmake gtest ];
}
