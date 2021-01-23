# dmftPackages

![cache](https://github.com/hmenke/dmftPackages/workflows/cache/badge.svg)

A package collection for DMFT simulations.

## Binary cache

Binaries are built nightly for the version of nixpkgs pinned in
[`flake.lock`](flake.lock), as well as for the latest stable and unstable branch
of NixOS and pushed to Cachix.  To use the cache, either execute
```console
$ nix-shell -p cachix --run "cachix use hmenke"
```
or append to these entries in your `nix.conf`
```
substituters = https://hmenke.cachix.org
trusted-public-keys = hmenke.cachix.org-1:Vxo5V5+3AoKc+zu/3MQaUqhPYtUfMwlu27jRYE3JZ/8=
```
*Don't delete the `cache.nixos.org` entries!*

## Installation

### As a channel

Add the channel
```console
$ nix-channel --add https://github.com/hmenke/dmftPackages/archive/master.tar.gz dmftPackages
$ nix-channel --update
```
and use
```nix
let
  dmftPackages = import <dmftPackages> {};
in
# ...
```

### As a tarball

Instead of adding it as a channel you can also fetch the tarball for a specific
commit to pin the versions
```nix
let
  dmftPackages = import (fetchTarball {
    url = "https://github.com/hmenke/dmftPackages/archive/df01f3b01c558b6629c3dee60a029fca221b65ee.tar.gz";
    sha256 = "1ybvqh9d5g94h3s3z44wsvz69frnbfpsdi0nxysyw5g9h9wgfagl";
  }) {};
in
# ...
```

### As a flake

The package set is also available as a flake.
```nix
{
  inputs.dmftPackages.url = "github:hmenke/dmftPackages";
  outputs = { self, nixpkgs, dmftPackages, ... }: {
    # ...
  };
}
```

However, all the packages are exported as a flattened tree with levels separated
by `/` because flakes doesn't support nested attribute sets in the `packages`
output.  So to use one of the nested packages you have to specify it as
```nix
dmftPackages.packages.x86_64-linux."triqsPackages/triqs"
```
or use the `legacyPackages` attribute
```nix
dmftPackages.legacyPackages.x86_64-linux.triqsPackages.triqs
```

## Notes

 1. When importing dmftPackages you can pass a specific version of nixpkgs as an
    argument to use a specific checkout of nixpkgs, e.g.
    ```nix
    let
      pinnedPkgs = import (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293.tar.gz";
        sha256 = "1ahn3srby9rjh7019b26n4rb4926di1lqdrclxfy2ff7nlf0yhd5";
      }) {};
      dmftPackages = import (fetchTarball {
        url = "https://github.com/hmenke/dmftPackages/archive/df01f3b01c558b6629c3dee60a029fca221b65ee.tar.gz";
        sha256 = "1ybvqh9d5g94h3s3z44wsvz69frnbfpsdi0nxysyw5g9h9wgfagl";
      }) { pkgs = pinnedPkgs; };
    in
    # ...
    ```

 2. Related to 1., when the `pkgs` argument is left out, the pinned version of
    nixpkgs from [`flake.lock`](flake.lock) will be used.

 3. The attribute names follow the directory structure.  The attribute names are
    also case-insensitive equal to `pname`.

 4. The w2dynamics program is hosted on a private repository but to compute the
    NAR hash for downloading the prebuilt binaries you need the source code, so
    unless you have access to the source you can neither download binaries nor
    build it yourself.

 5. All packages that have checks have their checks run when building to ensure
    the correctness of the resulting binaries.

 6. There is also an overlay in case you want to install these packages in your
    local or global environment, e.g. on NixOS.

## Known issues / TODO

  - Ensure that builds are reproducible

  - macOS builds
