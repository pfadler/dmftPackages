{ stdenv
, lib
, fetchFromGitHub
, cmake
, python3Packages
, python3
}:

let
  rev = "b268654da7a06fa526be58382b4f423b84bf5fe2";
in
stdenv.mkDerivation rec {
  pname = "cpp2py";
  version = "2.0.0+git20220304.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    inherit rev;
    sha256 = "sha256-69UG1T+CRG3+fWGO5peJhGQrT1MYmt1Z64/7GCk2Vi8=";
  };

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];
  buildInputs = [ python3 ];
  pythonPath = with python3Packages; [ h5py Mako numpy scipy ];
  propagatedBuildInputs = pythonPath;
  postFixup = "wrapPythonPrograms";

  doCheck = true;

  meta = {
    description = "Cpp2Py is the Python-C++ interfacing tool of the TRIQS project";
    homepage = "https://github.com/TRIQS/cpp2py";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
