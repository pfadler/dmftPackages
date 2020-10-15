{ stdenv, fetchFromGitHub, cmake, gtest, itertools, openmpi }:

stdenv.mkDerivation rec {
  pname = "mpi";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256:0winhwf2qsmp4ji72bghzkd3sz2rw94li86g6h1vk5vs4485x3i5";
  };

  patches = [ ./mpi.patch ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ itertools openmpi ];
}
