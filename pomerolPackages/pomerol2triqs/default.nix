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
  version = "0.7";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-na/jDQkbSaT36VXu02Xg1y8DvUeKH2gf46frkvW16iU=";
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
    homepage = "https://github.com/krivenko/pomerol2triqs";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
