{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) lib;
  inherit (lib) runTests;
in {
  "1_01" = runTests { test_1_01 = import ./1_01_about_asserts.nix; };
  "1_02" = runTests (import ./1_02_about_complex_asserts.nix);
  "1_03" = runTests (import ./1_03_about_primitive_types.nix);
  "1_04" = runTests (import ./1_04_about_complex_types.nix);
  "1_05" = runTests (import ./1_05_about_variables.nix);
  "1_06" = runTests (import ./1_06_about_strings.nix);
  "1_07" = runTests (import ./1_07_about_functions.nix);
  "1_08" = runTests (import ./1_08_about_files.nix {
    expected = "surprise!";
    transform = (x: (x // { expected = "another surprise"; }));
  });
  "2_01" = runTests (import ./2_01_about_semantics.nix { });
  "2_02" = runTests (import ./2_02_about_builtins.nix { });
  "2_03" = runTests (import ./2_03_about_imports.nix { inherit pkgs; });
  "2_04" = runTests (import ./2_04_about_recursion.nix { inherit pkgs; });
  "3_01" = runTests (import ./3_01_about_nix_store.nix { inherit pkgs lib; });
  "3_02" = runTests (import ./3_02_about_network.nix { inherit pkgs lib; });
  "3_03" = runTests (import ./3_03_about_derivations.nix { inherit pkgs lib; });
}
