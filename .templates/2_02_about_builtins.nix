{ ... }:

# Take a look at https://teu5us.github.io/nix-lib.html#nix-builtin-functions
# For a reference
{
  test_concatLists = {
    expr = null;
    expected = builtins.concatLists [ [ 1 ] [ 2 3 4 ] ];
  };

  test_hasAttr = {
    expr = null;
    expected = builtins.hasAttr "a" { b = 1; };
  };

  test_mapAttrs = {
    expr = null;
    expected = builtins.mapAttrs (name: value: value * 10) {
      a = 1;
      b = 2;
    };
  };

  test_map = {
    expr = null;
    expected = builtins.map (name: name * 10) [ 1 2 3 ];
  };

  test_listToAttrs = {
    expr = null;
    # Can we defined it in terms of other builtins?
    # Do we need attrToList?
    expected = builtins.listToAttrs [
      {
        name = "foo";
        value = 123;
      }
      {
        name = "bar";
        value = 456;
      }
    ];
  };

  test_foldl = {
    expr = null;
    expected = builtins.foldl' (a: b: a // { ${b.name} = b.value; }) { } [{
      name = "foo";
      value = 123;
    }];
  };

  test_attrsToList = {
    expr = null;
    expected = let
      attrSet = {
        a = 1;
        b = 2;
      };
    in (builtins.attrValues attrSet) ++ (builtins.attrNames attrSet);
  };

  test_nixHasReflection = {
    expr = null;
    expected = let f = { a, b, c ? 1 }: a + b + c; in builtins.functionArgs f;
  };
}
