{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, mpi
, openssh
}:

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
  buildInputs = [ triqsPackages.itertools mpi ];

  checkInputs = [ openssh ];
  doCheck = true;
  preCheck = lib.optional stdenv.isDarwin "export TMPDIR=/tmp";

  meta = {
    description = "mpi is a high-level C++ interface to the Message Passing Interface";
    homepage = "https://github.com/TRIQS/mpi";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
