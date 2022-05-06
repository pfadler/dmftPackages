{ buildPythonPackage
, lib
, fetchFromGitHub
, numpy
, scipy
, triqsPackages
, pytestCheckHook
}:
let
  rev = "6359be4f287bddd67db3a50960880de6b645f008";
in
buildPythonPackage rec {
  pname = "pyed";
  version = "1.0+git20220317.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "HugoStrand";
    repo = pname;
    inherit rev;
    sha256 = "sha256-/jHUbN6oEfSYRjJf8ap1xF4a5Vz27lNLaqM/RV8G4Sg=";
  };

  propagatedBuildInputs = [ numpy scipy triqsPackages.triqs ];

  checkInputs = [ pytestCheckHook ];
  doCheck = true;

  meta = {
    description = "Exact diagonalization for finite quantum systems";
    homepage = "https://github.com/HugoStrand/pyed";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
