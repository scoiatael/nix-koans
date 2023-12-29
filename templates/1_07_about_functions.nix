{
  test_nixHasFunctions = let a_function = x: x + 1;
  in {
    expr = null;
    expected = a_function 30;
  };

  test_nixFunctionsUsuallyTakeAttrSets = let a_function = { x }: x + 1;
  in {
    expr = null;
    expected = a_function { x = 10; };
  };

  test_nixFunctionsUsuallyReturnAttrSets = let a_function = x: { x = x + 1; };
  in {
    expr = null;
    expected = a_function 10;
  };

  # And so...
  test_nixFunctionsLookLikeBlocks = let a_function = { y }: { x = y + 1; };
  in {
    expr = null;
    expected = a_function { y = 20; };
  };

  test_nixFunctionsAreJustValues = {
    expr = null;
    expected = (({ y }: { x = y + 1; }) { y = 20; });
  };

  test_nixFunctionsCanTakeDefaultValues = let a_function = { y ? 100 }: y;
  in {
    expr = null;
    expected = (a_function { }) + (a_function { y = 1; });
  };

  test_nixFunctionsCanAcceptUnknownArguments = let a_function = { y, ... }: y;
  in {
    expr = null;
    expected = a_function {
      y = 1;
      x = 2;
      z = 3;
    };
  };

  test_nixFunctionsCanCaptureUnknownArguments = let
    a_function = { y, ... }@args: {
      inherit y;
      everything = args;
    };
  in {
    expr = null;
    expected = a_function {
      y = 1;
      x = 2;
      z = 3;
    };
  };
}
