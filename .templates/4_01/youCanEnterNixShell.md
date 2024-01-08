# Entering nix-shell

You can enter shell with `nix-shell`. It automatically picks up `shell.nix` in current directory.

Do so in this directory - and the flag shall be revealed! Play around, then open the file and come back here for explanations :)

## Relation between nix the lang and shell.nix

From previous koans we know that nix the language can be used to write complex build recipes for software packages.

`nix-shell` is (was?) primarily designed to help debug the process: create an interactive shell, where the build process can be tested and tweaked.

Henceforth it:
- build all dependencies,
- sets up build environment,
- starts configured shell (by default bash) in that environment,

It turned out that this process is quite useful in different contexts.
For me it's per-project dependency management.
Setup is simple: have all the OS-level dependencies (libraries and programs) listed as dependencies, all the language-specific code (like installing npm or PyPi packages) in shell setup.

This makes every project independent and setup consistent between different developers.

## Anatomy of shell.nix

Ok, but how does what we talked above translate to nix expressions?

`shell.nix` is a lambda function: its arguments `pkgs` (with default value of nixpkgs user channel) and its body `mkShell` invocation.`mkShell` comes from `nixpkgs` and is useful wrapper around `derivation` which we talked about in 3_03.

The [`mkShell`](https://ryantm.github.io/nixpkgs/builders/special/mkshell/) takes simplified version of `derivation` arguments. Notable ones are:
- `buildInputs` - list of derivations this shell depends on. Usually one just lists packages from https://search.nixos.org/packages (in form of `pkgs.<package name>`). `with pkgs` introduces all pkgs as top-level variables.
- `shellHook` - shell setup code. Here you can create virtualenv, install npm packages, seed databases, etc.
