{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, boost
, eigen
, gftools
, openmpi
, openssh
}:
let
  rev = "fd312b2bc1918e0fd2f463315efe01a84a4a25ef";
in
stdenv.mkDerivation rec {
  pname = "pomerol";
  version = "1.3+git20200410.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "aeantipov";
    repo = pname;
    inherit rev;
    sha256 = "sha256-gsm9f1XFD7i51aylEAEOpMPjQKsGkhpmSO7z4fN61To=";
  };

  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [
    "-DTesting=ON"
    "-DProgs=ON"
    "-DCXX11=ON"
    "-DCMAKE_SKIP_BUILD_RPATH=OFF"
  ];
  buildInputs =
    let
      boostWithMpi = boost.override {
        useMpi = true;
        mpi = openmpi;
      };
    in
    [ boostWithMpi eigen gftools openmpi ];

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
