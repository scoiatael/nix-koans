{ pkgs ? import (builtins.fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/057f9aecfb71c4437d2b27d3323df7f93c010b7e.tar.gz")
  { } }:

let base = import ./default.nix { inherit pkgs; };
in base.overrideAttrs { }
