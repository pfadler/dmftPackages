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
      name = "Loosen-type-check-of-hsize_t-to-restore-hdf5-1.13-co.patch";
      url = "https://github.com/TRIQS/h5/commit/ad98c8a33d3a7b60da2c80d02ded47629001adf8.patch";
      sha256 = "sha256-t0EBoxllJ4LXDFC+vM79YLMWwFs6Qr5oQsiEnzj4Fww=";
    })
    (fetchpatch {
      name = "cmake-Fix-h5-hdf5-interface-target-for-cmake-version.patch";
      url = "https://github.com/TRIQS/h5/commit/cae6ca2b47ca4e01c9210d3e900120c6af4573d8.patch";
      sha256 = "sha256-BMxgb7hArWkdwyH1fJEMcHcn7MJrhDUes0B+dC9kPdg=";
    })
    (fetchpatch {
      name = "fix-np.int-np.float-np.complex-removed.patch";
      url = "https://github.com/TRIQS/h5/commit/71a6cbfbb60c99cad17eb2bd8ae77cce9a08d5e4.patch";
      sha256 = "sha256-beO/mTopWr7TfICQhkotOxpJObLYLCavF0QpebLBzRU=";
    })
    (fetchpatch {
      name = "cmake-Fix-FindHDF5-logic-for-cmake-versions-3.23.patch";
      url = "https://github.com/TRIQS/h5/commit/18e96270c506917bb08e10006e8ceab6d67cbbb7.patch";
      sha256 = "sha256-tck2elNoUnjIviMZyuRZY8FAQp6XYQZF0hTe0r5uAjs=";
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
