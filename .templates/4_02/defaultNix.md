# default.nix

Previous section mentioned that `nix-shell` was just a helper to introspect building process, but due to its usefulness became a pattern on its own.

Now its time to dive into the build process.

The `./default.nix` file contains a pretty typical package definition:
- it uses `mkDerivation` (a cousin of `mkShell`) as lambda body,
- `src` is downloaded from Github using `fetchTarball`,
- build is simply invocation of rust compiler,
- and installation is just moving resulting binary to a final location,

## The flag

The flag for this exercise is location of resulting binary in nix store.

You can type `nix-build` to invoke nix build system; you'll find resulting binary in `./result/bin/ternimal`.
So getting the flag would be as easy as:

```
$ nix-build
this derivation will be built:
  /nix/store/xa3q686kkx5sy4c0kin35qhzn4n4ifwj-ternimal-0.1.0.drv
these 7 paths will be fetched (182.29 MiB download, 999.07 MiB unpacked):
  /nix/store/yyxp2w1rwni0cwsnsvldy7cxhmk8jai0-llvm-16.0.6
  /nix/store/3a5bdivizn6x5rbca2xn9a5gw18vym43-llvm-16.0.6-dev
  /nix/store/xnvy5pf8v1fa5jac1mxhg21f03n1gk2g-llvm-16.0.6-lib
  /nix/store/1diwjxki3ak3z4w8nnh9pahpgsqnd64l-ncurses-6.4-dev
  /nix/store/ac22m1yzmwgbr5y1prpw1d8xbrxp4m1s-ncurses-6.4-man
  /nix/store/y24qqyfbnnxza5841hd9hnda5icmzymq-rustc-1.74.0
  /nix/store/i2q9ff0fpgr20zza6kr6nlpki6mn43if-rustc-wrapper-1.74.0
copying path '/nix/store/xnvy5pf8v1fa5jac1mxhg21f03n1gk2g-llvm-16.0.6-lib' from 'https://cache.nixos.org'...
copying path '/nix/store/ac22m1yzmwgbr5y1prpw1d8xbrxp4m1s-ncurses-6.4-man' from 'https://cache.nixos.org'...
copying path '/nix/store/1diwjxki3ak3z4w8nnh9pahpgsqnd64l-ncurses-6.4-dev' from 'https://cache.nixos.org'...
copying path '/nix/store/yyxp2w1rwni0cwsnsvldy7cxhmk8jai0-llvm-16.0.6' from 'https://cache.nixos.org'...
copying path '/nix/store/3a5bdivizn6x5rbca2xn9a5gw18vym43-llvm-16.0.6-dev' from 'https://cache.nixos.org'...
copying path '/nix/store/y24qqyfbnnxza5841hd9hnda5icmzymq-rustc-1.74.0' from 'https://cache.nixos.org'...
copying path '/nix/store/i2q9ff0fpgr20zza6kr6nlpki6mn43if-rustc-wrapper-1.74.0' from 'https://cache.nixos.org'...
building '/nix/store/xa3q686kkx5sy4c0kin35qhzn4n4ifwj-ternimal-0.1.0.drv'...
Running phase: unpackPhase
unpacking source archive /nix/store/q4kklab36hpqrzfgf97i4gqr1v6qzkay-source
source root is source
Running phase: patchPhase
Running phase: updateAutotoolsGnuConfigScriptsPhase
Running phase: configurePhase
no configure script, doing nothing
Running phase: buildPhase
Running phase: installPhase
Running phase: fixupPhase
checking for references to /private/tmp/nix-build-ternimal-0.1.0.drv-0/ in /nix/store/wc2iq0sa4za4pb3889k9ngcz5z0yq3hb-ternimal-0.1.0...
patching script interpreter paths in /nix/store/wc2iq0sa4za4pb3889k9ngcz5z0yq3hb-ternimal-0.1.0
stripping (with command strip and flags -S) in  /nix/store/wc2iq0sa4za4pb3889k9ngcz5z0yq3hb-ternimal-0.1.0/bin
/nix/store/wc2iq0sa4za4pb3889k9ngcz5z0yq3hb-ternimal-0.1.0
$ readlink ./result
/nix/store/wc2iq0sa4za4pb3889k9ngcz5z0yq3hb-ternimal-0.1.0
```

The path `/nix/store/wc2iq0sa4za4pb3889k9ngcz5z0yq3hb-ternimal-0.1.0` is then the flag value :)

## The twist

But! This build is not consistent between us - since it depends on <nixpkgs> channel.

First pin the pkgs to the same version as in 4_01 and repeat the build.

The correct value starts looks like this:
```
/nix/store/ssxcx3<snip>-ternimal-0.1.0
```
