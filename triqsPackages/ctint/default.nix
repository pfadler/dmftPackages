{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, ncurses
, nfft
, openssh
}:

stdenv.mkDerivation rec {
  pname = "ctint";
  version = "3.1.0";

  src = builtins.fetchGit {
    url = "git+ssh://git@github.com/TRIQS/${pname}.git";
    ref = "refs/tags/${version}";
    rev = "03184d214c18fdd313da9b633d3a7b0b7f7cebac";
  };

  patches = [ ./ctint.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  buildInputs = [ ncurses nfft ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  UCX_LOG_FILE = "ucx.log";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Continuous-time interaction expansion quantum Monte-Carlo code based on TRIQS";
    homepage = "https://triqs.github.io/ctint/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
