{ stdenv
, lib
, fetchFromGitHub
, cmake
, alpsPackages
, boost
, eigen
, mpi
}:

let
  rev = "973d8cd1dc684af597503b945b808abae81cfde3";
in
stdenv.mkDerivation rec {
  pname = "CT-INT";
  version = "1.0+git.20210504.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "ALPSCore";
    repo = pname;
    inherit rev;
    sha256 = "sha256-xZ56fxhbXrwTkVSzHu6gABVBeq4x6s6SjBDC8KFtYRc=";
  };

  nativeBuildInputs = [ cmake ];
  #cmakeFlags = [ "-DCMAKE_SKIP_BUILD_RPATH=OFF" ];
  buildInputs = [ alpsPackages.alpsCore boost eigen mpi ];

  doCheck = true;

  meta = {
    description = "ALPS Interaction expansion code";
    homepage = "https://github.com/ALPSCore/CT-INT";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
