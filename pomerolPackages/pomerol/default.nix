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
  version = "2.0";

  src = fetchFromGitHub {
    owner = "aeantipov";
    repo = pname;
    rev = version;
    sha256 = "sha256-RlpcPVsLuvMeECpVp92nODDij9+tciySdUCOqrqFtvA=";
  };

  patches = [
    (fetchpatch {
      name = "fix-quantum_model-is-not-a-valid-prog.patch";
      url = "https://github.com/aeantipov/pomerol/commit/a7dee04938584c05dd827becd906e4a1483f5b53.patch";
      sha256 = "sha256-/QEzacrSnSsxeyjAHVH0N3bJFxQf2TgfGl88MqBctQ0=";
    })
    (fetchpatch {
      name = "CI-Update-value-of-libcommute_DIR-CMake-var-after-kr.patch";
      url = "https://github.com/aeantipov/pomerol/commit/6de692ba27109972b279085f6c2bf6bbad2fc986.patch";
      sha256 = "sha256-iI+E8oFuasFf5KIc/TvyisOarSY5nEb1/o9QfLGGexM=";
    })
  ];
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
