{ stdenv
, lib
, fetchFromGitHub
, cmake
, alpsPackages
, boost
, eigen
, mpi
}:

stdenv.mkDerivation rec {
  pname = "CT-HYB";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "ALPSCore";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-hciV8gfCQwQE2k+7FGnUnUV3cO4jeCvOaeeKXymwAqU=";
  };

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [ "-DCMAKE_SKIP_BUILD_RPATH=OFF" ];
  buildInputs = [ alpsPackages.alpsCore boost eigen mpi ];

  doCheck = true;

  meta = {
    description = "ALPS Hybridization Expansion Matrix Code";
    homepage = "https://github.com/ALPSCore/CT-HYB";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
