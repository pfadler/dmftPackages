{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, boost
, eigen
, openssh
}:

let
  rev = "d79810dd705b8e2efa802321382ebb7658e5f452";
in
stdenv.mkDerivation rec {
  pname = "gftools";
  version = "1.1.2+git20201027.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "aeantipov";
    repo = pname;
    inherit rev;
    sha256 = "sha256-UW64iWNu+ixkCC+0agdd9l09hT1z4DlBe6DAz2fpSXI=";
  };

  patches = [ ./gftools.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DTesting=ON" "-DExamples=ON" ];
  buildInputs = [ boost eigen ];

  doCheck = true;

  meta = {
    description = "gftools is a set of tools to work with numerical condmat problems";
    homepage = "https://github.com/aeantipov/gftools";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
