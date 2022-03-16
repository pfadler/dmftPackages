{ buildPythonPackage
, lib
, fetchFromGitHub
, pomerolPackages
, packaging
, pybind11
, numpy
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pycommute";
  version = "0.7.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-W9llhd4pGzWSjGgSlc60aDBMIJnpyAgb8UIbs2mrBOw=";
  };

  nativeBuildInputs = [ packaging pybind11 ];
  buildInputs = [ pomerolPackages.libcommute ];
  propagatedBuildInputs = [ numpy ];

  preCheck = ''
    cd tests
  '';
  checkInputs = [ pytestCheckHook ];
  doCheck = true;

  meta = {
    description = "Python bindings for libcommute";
    homepage = "https://krivenko.github.io/pycommute/";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
