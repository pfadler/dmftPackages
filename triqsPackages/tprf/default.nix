{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, ncurses
, openssh
}:

stdenv.mkDerivation rec {
  pname = "tprf";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-+bZ/FZT//KD77iXKidH5nROIfBHsgZ4Od2Gx8CqRDqM=";
  };

  patches = [ ./tprf.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  buildInputs = [ ncurses ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "TPRF: The Two-Particle Response Function tool box for TRIQS";
    homepage = "https://triqs.github.io/tprf/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
