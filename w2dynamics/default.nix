{ stdenv
, lib
, fetchFromGitHub
, cmake
, gfortran
, openblasCompat
, fftw
, nfft
, python3
, python3Packages
}:

stdenv.mkDerivation rec {
  pname = "w2dynamics";
  version = "1.1.3";

  src = fetchFromGitHub {
    owner = "w2dynamics";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-4py4xBVD6kN8D/If+bXn+4OjwI1n6m1M1puZbA3fBbE=";
  };

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];

  cmakeFlags = [ "-DUSE_NFFT=1" ];

  enableParallelBuilding = false;

  buildInputs = [ gfortran openblasCompat fftw nfft ];

  pythonPath = with python3Packages; [ numpy scipy h5py mpi4py configobj ];
  propagatedBuildInputs = pythonPath;

  postFixup = "wrapPythonPrograms";

  doCheck = true;

  meta = {
    description = "Wien/Wuerzburg strong coupling solver";
    homepage = "https://github.com/w2dynamics/w2dynamics";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
