{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, gtest
, triqsPackages
, ncurses
, openssh
}:

stdenv.mkDerivation rec {
  pname = "tprf";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-+bZ/FZT//KD77iXKidH5nROIfBHsgZ4Od2Gx8CqRDqM=";
  };

  patches = [
    (fetchpatch {
      name = "py-fix-numpy-depr-warnings-errors-with-modern-numpy";
      url = "https://github.com/TRIQS/tprf/commit/f3130a3aa8c6ea2380cea1c825af2c467e614a1f.patch";
      sha256 = "sha256-Z2FCeJ332d/a/aBe6hpoaPnkUa9+Q47zImb3wVoxs4w=";
    })
    (fetchpatch {
      name = "py-one-more-numpy-depr-fix";
      url = "https://github.com/TRIQS/tprf/commit/b7edb9b67081482f18953d032953b8aaf31dd1bc.patch";
      sha256 = "sha256-iERnBVnu/CKPUS08Ddzt+y8lUmSQr4/1M5vstCVePKA=";
    })
    ./tprf.patch
  ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  buildInputs = [ ncurses ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "TPRF: The Two-Particle Response Function tool box for TRIQS";
    homepage = "https://triqs.github.io/tprf/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
