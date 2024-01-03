{ ... }:

{

  test_nixAllowsRecursion =
    let f = x: if x <= 0 then 1 else (f (x - 1)) + (f (x - 2));
    in {
      expr = null;
      # 1 2 3 5 8...
      expected = f 5;
    };

  test_nixAllowsLazyRecursion =
    let f = x: y: { ${x} = y; } // { next = f "next_${x}" (y + 10); };
    in {
      expr = null;
      expected = (f "foo" 11).next.next_foo;
    };

  test_nixAllowsCrazyRecursion = let
    f = builder: args:
      (builder args) // {
        args = args;
        builder = builder;
        rebuild = newArgs: (f builder (args // newArgs));
      };
  in {
    expr = null;
    expected = ((f ({ x, y, ... }: { result = x + y; }) {
      x = 10;
      y = 100;
    }).rebuild { x = 20; }).result;
  };
}
