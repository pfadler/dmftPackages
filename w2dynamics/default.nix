{ stdenv
, cmake
, gfortran
, openblasCompat
, fftw
, nfft
, python3
, python3Packages
}:
let
  rev = "199783a828b66c675c430321f2d23a4595bd485e";
in
stdenv.mkDerivation rec {
  pname = "w2dynamics";
  version = "git-${builtins.substring 0 7 rev}";

  src = builtins.fetchGit {
    url = "git@git.physik.uni-wuerzburg.de:hmenke/w2dynamics.git";
    inherit rev;
  };

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];

  cmakeFlags = [ "-DUSE_NFFT=1" ];

  enableParallelBuilding = false;

  buildInputs = [ gfortran openblasCompat fftw nfft ];

  pythonPath = with python3Packages; [ numpy scipy h5py mpi4py configobj ];
  propagatedBuildInputs = pythonPath;

  postFixup = "wrapPythonPrograms";

  doCheck = true;
}
