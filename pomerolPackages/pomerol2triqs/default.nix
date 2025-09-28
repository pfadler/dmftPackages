{ stdenv
, lib
, fetchFromGitHub
, cmake
, pomerolPackages
, triqsPackages
, ncurses
, mpi
, openssh
}:

stdenv.mkDerivation rec {
  pname = "pomerol2triqs";
  version = "0.10";

  src = fetchFromGitHub {
    owner = "pomerol-ed";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-MQOzvqIwE0nMnfDyiUaXiNuOif4ksqBefMAgJE4y8qo=";
  };

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [ "-DCMAKE_SKIP_BUILD_RPATH=OFF" ];
  buildInputs = [ mpi ncurses pomerolPackages.pomerol ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  OMPI_MCA_rmaps_base_oversubscribe = "yes";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Quick and dirty TRIQS wrapper around the Pomerol exact diagonalization library";
    homepage = "https://github.com/pomerol-ed/pomerol2triqs";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
