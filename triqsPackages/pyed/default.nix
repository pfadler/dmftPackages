{ buildPythonPackage, fetchFromGitHub, numpy, scipy, triqs }:
let
  rev = "e6a5b7db20d3cc94383e29c9050ffc47267a8584";
in
buildPythonPackage rec {
  pname = "pyed";
  version = "1.0+git20210122.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "HugoStrand";
    repo = pname;
    inherit rev;
    sha256 = "sha256-6yyGhnvg8aYDi0EYdYfD+IJANLfaUIsyiWPXlbMDvjM=";
  };

  propagatedBuildInputs = [ numpy scipy triqs ];

  doCheck = false;
}
