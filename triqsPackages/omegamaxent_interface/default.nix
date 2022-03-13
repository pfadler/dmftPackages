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
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-k6SsNuYFOmxN0K/jysYzA3ONHR2QIzFDe+f1Jjulngo=";
  };
  patches = [ ./omegamaxent_interface.patch ];

  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
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
    broken = stdenv.isDarwin;
  };
}
