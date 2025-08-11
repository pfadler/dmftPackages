{ buildPythonPackage
, lib
, fetchFromGitHub
, numpy
, scipy
, triqsPackages
, pytestCheckHook
}:
buildPythonPackage rec {
  pname = "pyed";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "HugoStrand";
    repo = pname;
    rev = version;
    sha256 = "sha256-/i2h56ISQqUIVXfSclgRWq4mgv9yzdqb9KpHyEBJZXw=";
  };

  patches = [ ./pyed.patch ];

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
