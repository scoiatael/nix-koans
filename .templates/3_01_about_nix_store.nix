{ lib, pkgs, ... }:

# when browsing https://teu5us.github.io/nix-lib.html you might've noticed
# nix is very unlike Python: stdlib has great deal of helpers to work with paths and versions,
# and very little to do "general" stuff like HTTP connections.
# This is because nix is focused on building software and not a general programming language
# (although it is Turing-complete).
rec {
  a_file = builtins.toFile "sample_file.txt" "hello";
  a_dir = null;

  # one major abstraction that is result of this focus is nix store.
  # it resides under /nix/store
  test_nixStorePath = {
    expr = null;
    expected = builtins.dirOf a_file;
  };

  # and every file and directory there starts with hash.
  # this hash is representation of instructions on how to obtain that file/directory.
  test_nixStoreAddress = {
    expr = null;
    expected = builtins.baseNameOf a_file;
  };

  # observe how another invocation of "toFile" writes to the same location
  test_nixStoreAddressOfAnotherFile = {
    expr = null;
    expected = builtins.baseNameOf (builtins.toFile "sample_file.txt" "hello");
  };

  # but a file with different content gets a different path
  test_nixStoreAddressOfADiffirentFile = {
    expr = null;
    expected = builtins.baseNameOf (builtins.toFile "sample_file.txt" "hello2");
  };

  # otherwise these are just normal files/directories.
  test_nixFileContent = {
    expr = null;
    expected = builtins.readFile a_file;
  };
}
