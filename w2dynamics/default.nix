{ stdenv, cmake, gfortran, openblas, fftw, nfft, python3, python3Packages }:

stdenv.mkDerivation rec {
  pname = "w2dynamics";
  version = "git";

  src = builtins.fetchGit {
    url = "git@git.physik.uni-wuerzburg.de:w2dynamics/w2dynamics.git";
    rev = "fef092443f4f84294209931b5b0a6a6a903f0a77";
  };

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];

  cmakeFlags = [ "-DUSE_NFFT=1" ];

  enableParallelBuilding = false;

  buildInputs = [ gfortran openblas fftw nfft ];

  pythonPath = with python3Packages; [ numpy scipy h5py mpi4py configobj ];
  propagatedBuildInputs = pythonPath;

  postFixup = "wrapPythonPrograms";
}
