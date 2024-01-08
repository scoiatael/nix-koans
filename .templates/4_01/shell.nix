{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [ ripgrep gawk ];
  shellHook = ''
    echo -ne "the flag is:\n\t"
    rg youcanenternixshell ../flags.nix | awk '{ print $7 }'
  '';
}
