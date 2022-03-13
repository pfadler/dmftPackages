{ stdenv
, lib
, fetchFromGitHub
, cmake
, eigen
}:

stdenv.mkDerivation rec {
  pname = "libcommute";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-cw+PlIkDg2kIXx5B63CXujAhY8B96dcrTVX0vu0bf88=";
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
