{ stdenv, fetchFromGitHub, cmake, gtest, boost, eigen, openssh }:

stdenv.mkDerivation rec {
  pname = "gftools";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "aeantipov";
    repo = pname;
    rev = version;
    sha256 = "sha256-FFdyIPnJLfhp59QPWUyOiNDoIndifAorRqWPfT0pC4Q=";
  };

  patches = [ ./gftools.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DTesting=ON" "-DExamples=ON" ];
  buildInputs = [ boost eigen ];

  doCheck = true;
}
