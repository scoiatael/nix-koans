# https://nixos.org/manual/nix/stable/language/values
{
  test_nixHasStrings = {
    expr = null;
    expected = "This is a string";
  };

  test_nixHasIntegers = {
    expr = null;
    expected = 1; # This is an integer
  };

  test_nixHasFloats = {
    expr = null;
    expected = 1.0; # This is a floating-point number
  };

  test_nixHasPaths = {
    expr = null;
    expected = ./a/path/to/something/on_disk.txt; # This is a path
  };

  test_nixHasBooleans = {
    expr = null;
    expected = true; # or false
  };

  test_nixHasNull = {
    expr = null;
    expected = null; # nothing to see here, right?
  };

}
