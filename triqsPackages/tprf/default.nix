{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, gtest
, triqsPackages
, openssh
}:

stdenv.mkDerivation rec {
  pname = "tprf";
  version = "3.3.1";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-0cgf5O4junHmMOljzi8xVx/BkLHOCzK36nK8oOy1NC0=";
  };

  patches = [ ./tprf.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  # Documentation specifies 'a working triqs installation,
  # such that we moved the buildinputs were moved to triqs propagatedBuildInputs'
  buildInputs = [  ];
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
