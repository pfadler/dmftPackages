{ stdenv
, lib
, fetchFromGitHub
, cmake
, python3Packages
, llvmPackages
, python3
}:

stdenv.mkDerivation rec {
  pname = "cpp2py";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256:1byl6rvb48whkwblalhiaypgccl9m9yijx8rwr9dfbffl97zcsdv";
  };
  patches = [ ./no-auto-template-arguments.patch ];

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];
  cmakeFlags = [ "-DLIBCLANG_CXX_FLAGS=--pipe" ]; # noop flag to work around CMake bug
  buildInputs = [ llvmPackages.libclang python3 ];
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
