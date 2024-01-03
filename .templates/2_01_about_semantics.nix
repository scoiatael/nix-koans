# We'll keep using this convention of each file being a lambda function
{ ... }:

{
  # And jump straight to semantics of nix language

  test_nixHasAssert = {
    expr = null;
    # What would happen if we tried to "assert false; 1" here?
    expected = assert true; 1;
  };

  test_nixHasTryEval = {
    expr = null;
    expected = builtins.tryEval (assert false; 1);
  };

  test_nixIsLazy = {
    expr = null;
    expected = true;
    # this never has to be evaluated:
    _else = assert false; true;
  };

  test_nixHasImplication = {
    expr = null;
    expected =
      [ (false -> false) (false -> true) (true -> false) (true -> true) ];
    # this is quite useful for stuff like:
    # assert (target = "linux") -> disableUI
  };
}
