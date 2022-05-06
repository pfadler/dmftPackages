{ stdenv
, lib
, fetchFromGitHub
, cmake
, alpsPackages
, openblasCompat
, mpi
, nfft
}:
let
  rev = "156e906032878f9536cd03cb1f9a3bace3ee6011";
in
stdenv.mkDerivation rec {
  pname = "CT-HYB-SEGMENT";
  version = "1.0+git.20220125.${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "ALPSCore";
    repo = pname;
    inherit rev;
    sha256 = "sha256-91J9j9Agn0pP0FcvOZgAEwTmmeJPO5EG7b3zy8jbsEg=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ alpsPackages.alpsCore openblasCompat mpi nfft ];

  doCheck = true; # Hm, no tests...

  meta = {
    description = "ALPS hybridization expansion quantum impurity solver, based on the segment representation";
    homepage = "https://github.com/ALPSCore/CT-HYB-SEGMENT";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
