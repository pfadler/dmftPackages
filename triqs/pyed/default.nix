{ buildPythonPackage, fetchFromGitHub, numpy, triqs }:

let rev = "7d42498f217101cc725aed6c20647360ec01aad0";
in buildPythonPackage rec {
  pname = "pyed";
  version = "git-${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "HugoStrand";
    repo = pname;
    inherit rev;
    sha256 = "00pa34pkpww7sl02h6zx4v44h4np3yhc6nic4v3fc16lqa50f0hx";
  };

  patches =
    [ ./0001-setup.py.patch ./0002-pytriqs-triqs.patch ./0003-2to3.patch ];

  propagatedBuildInputs = [ numpy triqs ];

  doCheck = false;
}
