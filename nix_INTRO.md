# What is nix?

![](https://cdn.xeiaso.net/file/christine-static/talks/2023/asg-nixos/019.avif)

nix is a programming language with features focused on description of software building process. In contrast to things like Make, it aims to fully encompass the process, including things commonly omitted like:
- OS-level shared libraries (on both _host_ and _target_ systems),
- compiler _version_, _flags_ and _configuration_,

To put it simply: running recipe written in nix on any OS should result in the same artifact - down to checksum of each file. It doesn't mean that when building on macOS you'll get Linux executables - target OS is also part of the configuration. Some things may only target macOS, or only Windows (via Windows Subsystem Linux).

On top of nix-the-language, there are:
- several nix Domain Specific Languges (e.g. for building software, managing your $HOME configuration, setting up macOS / Linux systems),
- nixpkgs - the canonical repository for software recipes written in nix DSL and resulting binary artifacts,
- nixOS - GNU/Linux distribution using nix DSL and nixpkgs as primary way of configuration for the whole system,

This repository focuses on nix the language, and some features of nixpkgs.

Sources:
- https://xeiaso.net/talks/asg-2023-nixos/
- https://nixos.wiki/wiki/Overview_of_the_Nix_Language

# Installation

To the best of my knowledge, the canonical way to install nix is via https://nixos.org/download - don't be discouraged by the "nixos" part there.
The heading should read "Nix: the package manager" (and "current version" is "2.19.2", which will likely change in the future).

Other notable installers are :
- https://github.com/DeterminateSystems/nix-installer - claims to be more resilient to system upgrades on macOS - check it out if you have Apple hardware :)
- https://github.com/nix-community/nix-installers - several distros feature nix installers in their source repositories. Might offer better integration with host system if you use Linux distro that has it.

Sources:
- https://nixos.org/manual/nix/stable/installation/installation
- https://determinate.systems/posts/determinate-nix-installer
- https://wiki.archlinux.org/title/Nix

# Tips and tricks

After you install nix, make sure to play around with it before starting the koans :)

Some interesting things you might wanna check out:

1. Search for your favourite program on https://search.nixos.org and check out various modes of installing it via nix. Most notably `nix-shell` and `nix-env`,
2. Experiment with your $SHELL and ways to integrate with nix: https://github.com/direnv/direnv/wiki/Nix ,
3. Configure your nix installation via `/etc/nix/nix.conf` - at least enable `experimental-features = nix-command flakes` to make yourself a favour :)
4. Run `nix repl` - you can experiment with nix-the-language there! It will be useful when working on the koans.


Some more advanced stuff that might be useful later (and this koans won't cover them):
1. Getting to know about nix channels (https://nixos.wiki/wiki/Nix_channels) - these were a primary way of getting newer packages in nix, but are becoming more and more obsolete due to Flakes,
2. Learning about nix garbage collection (https://nixos.org/guides/nix-pills/garbage-collector.html) - still relevant if you don't want your `/nix` to overwhelm your whole hard driver in the future,

Sources:
- https://stop-using-nix-env.privatevoid.net

# Why a separate language?

A fair question is: why do we need a new language?
A (possibly) simpler solution would be to use an existing general programming language, like TypeScript, Python, or maybe a configuration language like YAML or TOML and build on top of that.

What would be the pros of that?
- no need to learn a new syntax and semantics,
- we could leverage existing set of packages,
- we could leverage existing package registry system,

Now consider that in any language used "build expressions" have to be "pure" - in the mathematical sense - to capture all dependencies of given package.
That doesn't mean that programming language used has to be pure, but makes implementation a bit harder (since theoretical "nix.py"/"nix.ts" cannot be a shallow DSL in given language),
That in turn means that our general programming language would have to just output certain structures to be consumed by the "nix driver", which evaluates them as expressions.

And that effectively nullifies everything we'd gain by using an existing language: one has to learn new semantics (of that nix driver), and can't just use any existing libraries since these need to be compatible with "nix expressions".
Instead we can write a new language that directly corresponds to the needs of this new system, which is well described in 4.1 section of "nix thesis" :)

Sources:
- https://jonathanlorimer.dev/posts/nix-thesis.html
- https://edolstra.github.io/pubs/phd-thesis.pdf
- https://jade.fyi/blog/flakes-arent-real/
