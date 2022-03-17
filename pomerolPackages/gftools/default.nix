{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, boost
, eigen
, openssh
}:

stdenv.mkDerivation rec {
  pname = "gftools";
  version = "2022.03";

  src = fetchFromGitHub {
    owner = "aeantipov";
    repo = pname;
    rev = version;
    sha256 = "sha256-miaG9vw1w+7w1+MMl1f/Yn/0B1IUt6CPWww3BeDNrLA=";
  };

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
