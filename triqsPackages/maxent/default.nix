{ stdenv
, lib
, fetchFromGitHub
, cmake
, triqsPackages
, python3Packages
, openssh
}:

stdenv.mkDerivation rec {
  pname = "maxent";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-AQkywhB6EaGJlMMUdG1c+uOnWwvuEhSd1EZQgQFSSAk=";
  };

  nativeBuildInputs = [ cmake python3Packages.wrapPython ];
  pythonPath =  [ python3Packages.decorator ];
  propagatedBuildInputs = pythonPath ++ [ triqsPackages.triqs ];

  enableParallelChecking = false;
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Maximum Entropy Codes";
    homepage = "https://triqs.github.io/maxent/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
