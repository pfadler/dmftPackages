{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, gtest
, triqsPackages
, ncurses
, openssh
}:

stdenv.mkDerivation rec {
  pname = "tprf";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-zgSX1sliQ6QYNx/D1WZ6cRuYHN/UJYnQfOVi3WDda4k=";
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
