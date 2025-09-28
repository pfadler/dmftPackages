{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
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
  version = "2.2";

  src = fetchFromGitHub {
    owner = "pomerol-ed";
    repo = pname;
    rev = version;
    sha256 = "sha256-s65GSNZcV2virhc6WquhhdNs7YojendQSDHQycSsi7I=";
  };

  # The tests will fail, if it is impossible to spawn 16 mpi processes
  # this patch will limit it to a reasonable 4
  patches = [ ./mpitest.patch ];

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
    homepage = "https://github.com/pomerol-ed/pomerol";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
