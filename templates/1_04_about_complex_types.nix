{
  test_nixHasLists = {
    expr = null;
    expected = [ 1 2.0 "a string" /and/a/path.txt ];
  };

  test_nixHasAttrSets = {
    expr = null;
    expected = {
      this = "is an attr set";
      "keys can contain spaces" = "and values can be anything";
      for_Example = 1;
    };
  };

  test_nixCanTakeAttrSetAttr = {
    expr = null;
    expected = { this = "is a value"; }.this;
  };

  test_nixCantTakeListElem = {
    expr = null;
    # This is an error:
    # expected = [ 1 2 3 ] [ 0 ];
    # instead you have to use a function (from builtins module)
    expected = builtins.elemAt [ 0 1 2 ] 1;
  };

  test_nixCanMergeAttrSets = {
    expr = null;
    expected = { x = 1; } // { y = 2; };
  };

  this = "whole file is an attr set";
}
