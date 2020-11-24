{ stdenv, fetchFromGitHub, cmake, boost, eigen, hdf5, openmpi, openssh }:

stdenv.mkDerivation rec {
  pname = "ALPSCore";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "ALPSCore";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256:0brnbly6p227x2lw28rlx9wl64yff3x13wfy9kwl9jjil97r6ryl";
  };

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [ "-DENABLE_MPI=On" "-DCMAKE_SKIP_BUILD_RPATH=OFF" ];
  buildInputs = [ boost eigen hdf5 openmpi ];

  # Don't try to build this on an overcommitted system
  enableParallelChecking = false;
  checkInputs = [ openssh ];
  doCheck = false;
}
