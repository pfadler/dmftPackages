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
  version = "0.7.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-zx3z1Gkpj7+/7JVF7TghW61ewoTZMMaKYmMwqFQ8YBE=";
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
    broken = pomerolPackages.libcommute.version != version;
  };
}
