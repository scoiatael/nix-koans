# Pinning nixpkgs

As you saw in the previous example, the `pkgs` argument to `shell.nix` can be an import.

By default `import <nixpkgs>` will pick current version of user `nixpkgs` channel. 

This is bad for repeatability - each developer will have checked out a different version of the channel - and some may not even have updated in a long while!

And so a version that works for me, might not work for someone else - due to missing packages, different library versions, etc.

To solve the problem we need a combination of two features:
- importing an arbitrary expression,
- fetching "frozen" version of nixpkgs from the internet.

Let's tackle those :)

## Importing an arbitrary expression

As you've seen in 2_03, nix `import` expression can pick any nix file on the filesystem by passing a path as argument. This can even be a path to something in nix store :)

In fact, the "special" version of `import <$CHANNEL>` does leverage it: it first reads entries in `~/.nix-defexpr/channels_root/manifest.nix` and then picks the appropriate `outPath`, which points to nix store, e.g. `/nix/store/j8sh7dkdp9lrlw6qhyj415zzy8vg2ds2-nixpkgs`.

## Fetching version of nixpkgs from the internet

As you've seen in 3_02, nix can fetch arbitrary files from the network to `/nix/store`. 

The option useful for us will be `builtins.fetchTarball` - we can't use `nixpkgs` yet, since we want to fetch them ;)

Nixpkgs are hosted on github: https://github.com/NixOS/nixpkgs and we can leverage the `archive` feature to fetch whole repository by pointing to `<repo>/archive/<commit>.tar.gz`.
Release also works, but commit hash is guaranteed to be immutable, so it's a good practice to use those.

And so we can use `builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/f8870b21f55e31248a04a1b52d838f9a5757e47e.tar.gz"` to get specific version downloaded to `/nix/store`. It will return a path to nix store, like `/nix/store/7wrwcly1j6nxnmwnmhq489dpxk147vq4-source`- take a look on your own in `nix repl` :)

"Downloading whole repository" sounds weird when talking about packages, right? But thankfully nixpkgs repo contains only nix expressions - a lot of recipes on how to build stuff, but none of the source code or binary artifacts.
That's why downloading it entirely is acceptable - but still weighs around 250Mb right now and is bound to increase in the future due to sheer number of new packages being added.

## Getting the flag

Modify `shell.nix` in this directory to use pinned version of nixpkgs corresponding to this commit: https://github.com/NixOS/nixpkgs/commit/057f9aecfb71c4437d2b27d3323df7f93c010b7e.

Then enter the shell and run the following script to get the flag:

```
which rg | cut -d/ -f 4 | cut -d- -f 1 | xargs printf 'The flag is: "%s";'
```

