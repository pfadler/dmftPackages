{ buildPythonPackage
, lib
, fetchFromGitHub
, numpy
, scipy
, triqsPackages
, pytestCheckHook
}:
let
  rev = "e2952c250f1505df54c39d150db4be9e44b3e012";
in
buildPythonPackage rec {
  pname = "pyed";
  version = "1.0+git20220208.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "HugoStrand";
    repo = pname;
    inherit rev;
    sha256 = "sha256-smQ7IdHTH02ZJMbvtE0clqy23eGyw0OdFRUVPfWm9yQ=";
  };

  patches = [ ./fix-tab-error.patch ];
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
