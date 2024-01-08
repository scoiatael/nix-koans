{ lib, pkgs, flags, ... }:

# this section will require a new approach
# these files will not longer be self-contained.
# Instead, take a look at ./4_01 directory - you will see some tasks which will give you a flag used to pass each step.
{
  # ./4_01/youCanEnterNixShell.md
  test_youCanEnterNixShell = {
    expr = null;
    inherit (flags._4_01_youcanenternixshell) expected;
  };

  # ./4_01/pinningNixpkgs.md
  test_pinningNixpkgs = {
    expr = null;
    inherit (flags._4_01_pinningnixpkgs) expected;
  };
}
