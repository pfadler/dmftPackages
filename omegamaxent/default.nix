{ stdenv
, lib
, fetchFromGitHub
, cmake
, fftw
, gsl
, openblasCompat
}:
let
  rev = "bbb8a7fa8520e3e8a5a57dd662ab93ff6809b369";
in
stdenv.mkDerivation rec {
  pname = "OmegaMaxEnt";
  version = "1.0+git20191128.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "amstremblay";
    repo = pname;
    inherit rev;
    sha256 = "sha256-W0A95VIcA2fGT63dnMYvBjRLM9jZkufjtX9Zcpx6Qd4=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fftw gsl openblasCompat ];

  doCheck = true; # Hm, no tests...

  meta = {
    description = "Omega MaxEnt: analytic continuation of numerical Matsubara data";
    homepage = "https://www.physique.usherbrooke.ca/MaxEnt/index.php/Main_Page";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
