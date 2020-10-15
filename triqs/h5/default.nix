{ stdenv, fetchFromGitHub, cmake, gtest, cpp2py, hdf5, ncurses }:

stdenv.mkDerivation rec {
  name = "h5";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = name;
    rev = version;
    sha256 = "sha256:07lahznp5cbkk2nnb88lia8s9qfgrwgb6y654ql4fss574skga5w";
  };

  patches = [ ./h5.patch ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ cpp2py hdf5 ncurses ];
}
