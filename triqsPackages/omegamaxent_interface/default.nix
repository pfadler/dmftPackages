{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, fftw
, gsl
, openblasCompat
, triqsPackages
, openssh
}:

stdenv.mkDerivation rec {
  pname = "omegamaxent_interface";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-JeqozCcqicurOSyoPepHYYzbHR4eoSCDgMfRkmliUug=";
  };
  patches = [ ./omegamaxent_interface.patch ];

  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ fftw gsl openblasCompat ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  enableParallelChecking = false;
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "TRIQS Interface to the OmegaMaxEnt Code";
    homepage = "https://triqs.github.io/omegamaxent_interface/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
