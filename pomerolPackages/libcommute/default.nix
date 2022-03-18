{ stdenv
, lib
, fetchFromGitHub
, cmake
, eigen
}:

stdenv.mkDerivation rec {
  pname = "libcommute";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-wpA0Rnv8ROku7ikncCby7rftFDUeNxO/AONS/0/ibLg=";
  };

  patches = [ ./install-targets.patch ];
  nativeBuildInputs = [ cmake ];
  buildInputs = [ eigen ];

  doCheck = true;

  meta = {
    description = "A quantum operator algebra domain-specific language and exact diagonalization toolkit for C++11/14/17";
    homepage = "https://github.com/krivenko/libcommute";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
