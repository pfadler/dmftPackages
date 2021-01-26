{ stdenv
, lib
, fetchFromGitHub
, cmake
, alpsPackages
, boost
, eigen
, gsl
}:

stdenv.mkDerivation rec {
  pname = "Maxent";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "CQMP";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256:1fkx0z8brqla3yis4f12p0qj3axiill8n0ima2xdnhq5iqz4jn1f";
  };

  patches = [ ./pthread.patch ];

  nativeBuildInputs = [ cmake ];

  buildInputs = [ alpsPackages.alpsCore boost eigen gsl ];

  doCheck = true;

  meta = {
    description = "A utility for performing analytic continuation using the method of Maximum Entropy";
    homepage = "https://github.com/CQMP/Maxent";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
