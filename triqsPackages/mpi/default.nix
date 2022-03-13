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
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-Bey01YCW81CcW+M/EAwHhF6sUQ2+W1fOJ7vXZIz2QWA=";
  };

  patches = [ ./mpi.patch ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
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
