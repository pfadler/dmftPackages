{ buildPythonPackage
, libclang
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "clang";
  version = libclang.version;
  src = "${libclang.src.outPath}/clang/bindings/python/";
  patches = [ ./0001-add-setup.py.patch ];
  CLANG_LIBRARY_PATH = "${libclang.lib.outPath}/lib";
  checkInputs = [ pytestCheckHook ];
}
