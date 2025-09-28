{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, eigen
}:

stdenv.mkDerivation rec {
  pname = "libcommute";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-BGn5q6sqVqWKiZDEqWw1ZLCAVoY2gIHFyx00BB3HGmE=";
  };

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
