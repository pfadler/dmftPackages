{ stdenv
, lib
, fetchFromGitHub
, autoconf
, automake
, libtool
, fftw
}:

stdenv.mkDerivation rec {
  pname = "nfft";
  version = "3.5.3";

  src = fetchFromGitHub {
    owner = "NFFT";
    repo = pname;
    rev = version;
    sha256 = "sha256-HR8ME9PVC+RAv1GIgV2vK6eLU8Wk28+rSzbutThBv3w=";
  };
  patches = [
    ./ac-check-decls.patch
    ./ac-maxopt.patch
  ];

  preConfigure = ''
    bash bootstrap.sh
  '';
  nativeBuildInputs = [ autoconf automake libtool ];
  configureFlags = [ "--enable-all" "--enable-openmp" ];
  propagatedBuildInputs = [ fftw ];

  doCheck = true;

  meta = {
    description = "Nonequispaced fast Fourier transform";
    homepage = "https://www-user.tu-chemnitz.de/~potts/nfft/";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
