{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, boost
, eigen
, pomerolPackages
, mpi
, openssh
}:

stdenv.mkDerivation rec {
  pname = "pomerol";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "aeantipov";
    repo = pname;
    rev = version;
    sha256 = "sha256-RlpcPVsLuvMeECpVp92nODDij9+tciySdUCOqrqFtvA=";
  };

  patches = [ ./no-quantum-model.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [
    "-DTesting=ON"
    "-DProgs=ON"
    "-DDocumentation=OFF"
    "-DCMAKE_SKIP_BUILD_RPATH=OFF"
  ];
  buildInputs = [
    boost
    eigen
    pomerolPackages.gftools
    pomerolPackages.libcommute
    mpi
  ];

  OMPI_MCA_rmaps_base_oversubscribe = "yes";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Exact diagonalization code for solving condensed matter second-quantized models of interacting fermions on finite size lattices at finite temperatures";
    homepage = "https://aeantipov.github.io/pomerol/";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
