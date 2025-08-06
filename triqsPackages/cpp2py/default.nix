{ stdenv
, lib
, fetchFromGitHub
, cmake
, python3Packages
, python3
}:

let
  rev = "d5663cfbefc5302ca1e6d3292cd019f41c81966e";
in
stdenv.mkDerivation rec {
  pname = "cpp2py";
  version = "2.0.0+git20241109.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    inherit rev;
    sha256 = "sha256-OidPEcfOIIFEFoQEeCsPwxGWQNCSBG8ESesw/688Bw4=";
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
