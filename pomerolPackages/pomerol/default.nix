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

  PRTE_MCA_rmaps_default_mapping_policy=":oversubscribe";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Exact diagonalization code for solving condensed matter second-quantized models of interacting fermions on finite size lattices at finite temperatures";
    homepage = "https://github.com/pomerol-ed/pomerol";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
