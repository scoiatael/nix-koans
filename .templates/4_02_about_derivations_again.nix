{ flags, lib, pkgs, ... }:

# See ./4_02 directory for getting flags.
{
  # ./4_02/defaultNix.md
  test_defaultNix = {
    expr = null;
    inherit (flags._4_02_defaultnix) expected;
  };

  # ./4_02/overrideAttrs.md
  test_overrideAttrs = {
    expr = null;
    inherit (flags._4_02_overrideattrs) expected;
  };
}
