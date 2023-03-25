{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, gtest
, python3Packages
, boost
, triqsPackages
, fftw
, gmp
, ncurses
, openblasCompat
, openssh
}:

stdenv.mkDerivation rec {
  pname = "triqs";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-Wp/x6ecX8t56ap1qogbFZ/jjSp6MRrmdyVrFLXqaG8I=";
  };

  patches = [
    ./triqs.patch
    (fetchpatch {
      name = "fix-np.int-etc.-removed-in-numpy-1.24.patch";
      url = "https://github.com/TRIQS/triqs/commit/886580a89176d8f1f9852c4c5dd344d258953464.patch";
      sha256 = "sha256-MOccsJOVqrtJ+z0wdJouqQAvhzzBKeYuFzvJtUx+Cr8=";
    })
    (fetchpatch {
      name = "Added-__array_priority__-to-the-Gf-class-to-make-sure-its-__rmul__.patch";
      url = "https://github.com/TRIQS/triqs/commit/cc85dc09543f03ed1865d863db639213a52534d2.patch";
      sha256 = "sha256-rAIZPh0mR0qkATY3sgwrDS2tipLJ6jSAyi/Iepkt9RM=";
    })
  ];
  nativeBuildInputs = [ cmake gtest python3Packages.wrapPython ];
  cmakeFlags = [ "-DCMAKE_SKIP_BUILD_RPATH=OFF" "-DBuild_Deps=Never" ];
  buildInputs = [
    boost
    fftw
    gmp
    ncurses
    openblasCompat
  ];
  pythonPath = with python3Packages; [ numpy matplotlib mpi4py Mako scipy ];
  propagatedBuildInputs = [
    triqsPackages.cpp2py
    triqsPackages.h5
    triqsPackages.nda
    triqsPackages.itertools
    triqsPackages.mpi
  ] ++ pythonPath;
  postFixup = "wrapPythonPrograms";

  UCX_LOG_FILE = "ucx.log";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Toolbox for Research on Interacting Quantum Systems";
    homepage = "https://triqs.github.io/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
