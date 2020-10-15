{ stdenv, fetchFromGitHub, cmake, alpsCore, boost, eigen, gsl }:

stdenv.mkDerivation rec {
  pname = "Maxent";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "CQMP";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256:1fkx0z8brqla3yis4f12p0qj3axiill8n0ima2xdnhq5iqz4jn1f";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [ "-DTesting=OFF" ];

  buildInputs = [ alpsCore boost eigen gsl ];
}
