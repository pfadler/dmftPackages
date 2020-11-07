{ stdenv, cmake, gfortran, blas-reference, lapack-reference, fftw, nfft, python3
, python3Packages }:

stdenv.mkDerivation rec {
  pname = "w2dynamics";
  version = "git";

  src = builtins.fetchGit {
    url = "git@git.physik.uni-wuerzburg.de:hmenke/w2dynamics.git";
    rev = "84a86f04d2d896b21e5c7c91f7b394aff6c3a4e8";
  };

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];

  cmakeFlags = [ "-DUSE_NFFT=1" ];

  enableParallelBuilding = false;

  buildInputs = [ gfortran blas-reference lapack-reference fftw nfft ];

  pythonPath = with python3Packages; [ numpy scipy h5py mpi4py configobj ];
  propagatedBuildInputs = pythonPath;

  postFixup = "wrapPythonPrograms";
}
