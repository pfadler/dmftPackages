{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, ncurses
, nfft
, openssh
, boost
}:

stdenv.mkDerivation rec {
  pname = "cthyb";
  version = "3.3.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-bZfjK08MsW/ZK6c2STi+pJAZjR/uJbV4UnMa6/hBzQA=";
  };

  patches = [ ./cthyb.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  buildInputs = [ ncurses nfft boost ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "A fast and generic hybridization-expansion solver";
    homepage = "https://triqs.github.io/cthyb/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
