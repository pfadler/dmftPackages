{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, gtest
, triqsPackages
, hdf5
, ncurses
, python3Packages
}:

stdenv.mkDerivation rec {
  pname = "h5";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-pqJrxsgkS+xYnEC98xBAbiw4oC72SBzS73IQBmcxjvU=";
  };

  patches = [
    ./h5.patch
    (fetchpatch {
      name = "Loosen-type-check-of-hsize_t-to-restore-hdf5-1.13-compatibility-Fix-11.patch";
      url = "https://github.com/TRIQS/h5/commit/ad98c8a33d3a7b60da2c80d02ded47629001adf8.patch";
      sha256 = "sha256-t0EBoxllJ4LXDFC+vM79YLMWwFs6Qr5oQsiEnzj4Fww=";
    })
    (fetchpatch {
      name = "Fix-hsize_t-for-hdf5-versions-1.13.patch";
      url = "https://github.com/TRIQS/h5/commit/d9af4b5b5de4c1e431bcafc55b29ef914937dc76.patch";
      sha256 = "sha256-Qjz4EiaQcLehCccQZ5aRv/muSGX1uf7UZPAd+RDuPGI=";
    })
  ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ triqsPackages.cpp2py hdf5 ncurses ];
  propagatedBuildInputs = with python3Packages; [ numpy ];

  doCheck = true;

  meta = {
    description = "h5 is a high-level C++ interface to the hdf5 library";
    homepage = "https://github.com/TRIQS/h5";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
