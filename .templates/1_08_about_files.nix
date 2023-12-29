# Most of nix files are actually functions from attr set into another attr set;
# The argument list:
{ expected, transform, ... }:

# And the body
{
  test_nixFilesAreUsuallyFunctions = {
    expr = null;
    inherit expected;
  };

  # And even worse...
  test_nixFilesOftenCallTheirArguments = transform {
    expr = null;
    # where did expected go?!
    # Take a look at ./test.nix ;)
  };
}
