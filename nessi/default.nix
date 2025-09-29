{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, eigen
, mpi
, hdf5
}:

stdenv.mkDerivation rec {
  pname = "nessi";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "nessi-cntr";
    repo = pname;
    rev = version;
    sha256 = "sha256-G3ItLHOsOc8Lr9Y2QnWtaN6oQAYCpv3Uz3Ea6tZR6o4=";
  };

  patches = [ (fetchpatch {
    name = "updated catch for new glibc";
    url = "https://github.com/nessi-cntr/nessi/commit/ed7d9429233c09cdd998678513ea4d983cf03fef.patch";
    hash = "sha256-5zrNK+iiNHQ9aNPogAQ56clKuRmgLVwIscvYByL0B6o=";
  })
           ];
  preConfigure = [ "cd libcntr" ];
  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" "-DCMAKE_CXX_FLAGS=\"-std=c++11\"" "-Domp=ON" "-Dmpi=ON" "-Dhdf5=ON" "-DBUILD_DOC=OFF" ];
  nativeBuildInputs = [ cmake ];
  buildInputs = [
    eigen
    mpi
    hdf5
  ];

  doCheck = true;

  meta = {
    description = "The NonEquilibrium Systems SImulation package.";
    homepage = "https://github.com/nessi-cntr/nessi";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ pfadler ];
  };
}
