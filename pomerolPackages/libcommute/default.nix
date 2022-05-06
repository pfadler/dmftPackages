{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, eigen
}:

stdenv.mkDerivation rec {
  pname = "libcommute";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "krivenko";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-wpA0Rnv8ROku7ikncCby7rftFDUeNxO/AONS/0/ibLg=";
  };

  patches = [
    (fetchpatch {
      name = "fix-install-CMake-config-in-subdirectory.patch";
      url = "https://github.com/krivenko/libcommute/commit/2e3202a278efc938be7d1241becc9d3f26d3f03e.patch";
      sha256 = "sha256-LLdV55Jd6V4tIQN+glxb5MqP7BdyjpXEct6cjP0kfBg=";
    })
    (fetchpatch {
      name = "doc-Consistently-use-lowercased-libcommute-in-CMake-.patch";
      url = "https://github.com/krivenko/libcommute/commit/863b67380742b4431b9170fbcdf51ff81172db0e.patch";
      sha256 = "sha256-+Gb8K/xjPnTmS8MYVSzimLS00rZJHY89kkNOzSOKryI=";
    })
    (fetchpatch {
      name = "test-Upgrade-bundled-Catch2-to-v2.13.9-fix-2.patch";
      url = "https://github.com/krivenko/libcommute/commit/98624b3b57875711f5958ee168e65d809c31bcbb.patch";
      sha256 = "sha256-1IuVKH1+7+ETDg+cebtbMySyvJs1d9x6ferxBBgn9pg=";
    })
  ];
  nativeBuildInputs = [ cmake ];
  buildInputs = [ eigen ];

  doCheck = true;

  meta = {
    description = "A quantum operator algebra domain-specific language and exact diagonalization toolkit for C++11/14/17";
    homepage = "https://github.com/krivenko/libcommute";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
