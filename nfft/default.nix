{ stdenv, fetchFromGitHub, autoconf, automake, libtool, fftw }:

stdenv.mkDerivation rec {
  pname = "nfft";
  version = "3.5.2";

  src = fetchFromGitHub {
    owner = "NFFT";
    repo = pname;
    rev = version;
    sha256 = "sha256:1liphapa64c16pw3dz2mqdq31jv5r01prdh1289616cvb1kp4232";
  };

  preConfigure = ''
    bash bootstrap.sh
  '';
  nativeBuildInputs = [ autoconf automake libtool ];
  configureFlags = [ "--enable-all" "--enable-openmp" ];
  buildInputs = [ fftw ];
}
