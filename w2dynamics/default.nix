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
  rev = "521f0f40ea7a0cfbef0faa82a4b7a6e030db1f9c";
in
stdenv.mkDerivation rec {
  pname = "w2dynamics";
  version = "1.0+git20210120.${builtins.substring 0 7 rev}";

  src = builtins.fetchGit {
    url = "git+ssh://git@git.physik.uni-wuerzburg.de/w2dynamics/w2dynamics.git";
    inherit rev;
  };

  patches = [ ./0001-Use-ISO-format-for-HDF5-timestamps.patch ];

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];

  cmakeFlags = [ "-DUSE_NFFT=1" ];

  enableParallelBuilding = false;

  buildInputs = [ gfortran openblasCompat fftw nfft ];

  pythonPath = with python3Packages; [ numpy scipy h5py mpi4py configobj ];
  propagatedBuildInputs = pythonPath;

  postFixup = "wrapPythonPrograms";

  doCheck = true;
}
