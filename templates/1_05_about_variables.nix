{
  test_nixHasVariables = let x = 1;
  in {
    expr = null;
    expected = x;
  };

  test_attrSetCanBeRecursive = {
    expr = null;
    expected = rec {
      x = 1;
      y = x;
    };
  };

  test_thereAreWaysToBringVariableToLocalScope = let
    vars = {
      x = 1;
      y = 2;
    };
  in {
    expr = null;
    expected = with vars; x + y;
  };

  test_thereAreWaysToBringVariableToLocalScope2 = let
    vars = {
      x = 1;
      y = 2;
    };
  in {
    expr = null;
    expected = with vars; { inherit x; };
  };

  test_thereAreWaysToBringVariableToLocalScope3 = let
    vars = {
      x = 1;
      y = 2;
    };
  in {
    expr = null;
    expected = { inherit (vars) x; };
  };
}
