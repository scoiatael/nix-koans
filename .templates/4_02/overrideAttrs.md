# Overriding build instructions

It's pretty common to get derivations from existing sources; nixpkgs is the primary but these can be essentially any location on the internet.

One common pain point is that build instructions might become outdated - this is especially irritating in nix, where the expression is self contained.

Let's take a look at `./default.nix` from previous step. It populates `src` field with github tarball pointing to a given commit.
If for some reason we wanted to update to a new version we would have a problem: how to override it?

We could copy the whole `default.nix` and substitute new version in `fetchTarball` - but this introduces needless duplication.

## Solution

This problem is common enough that `mkDerivation` contains a solution: the result contains `.overrideAttrs` field, which can be used to change derivation properties - much like we saw in crazy recursion section of 2_04 :)

Take a look at `./override.nix`.
You can build in with `nix-build override.nix`.

It contains basic setup for `.overrideAttrs` pattern - a base derivation is imported (and pinned nixpkgs are passed).

`overrideAttrs` accepts the same arguments as `mkDerivation` and builds result with new arguments merged into the old. 

## The flag

Build `override.nix` with `src` referencing https://github.com/ccraciun/ternimal/commit/fbde02ce833be56df1571dc9eb4e366579ea9f95 - this represents some bugfix PR not yet merged into main trunk.

The flag is again the result of `readlink result/`.

It looks like this:

```
/nix/store/3hgcgpv<snip>-ternimal-0.1.0
```

