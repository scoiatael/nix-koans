{
  test_nixHasMultilineStrings = {
    expr = null;
    expected = ''
      This
      is
      a multiline
      string
    '';
  };

  test_nixHasAntiQuotation = let x = "obviously";
  in {
    expr = null;
    expected = ''
      This ${x} is also a multiline
       string'';
  };

  test_nixCanEscapeAntiQuotation = let x = "obviously";
  in {
    expr = null;
    expected = "This \${x} is not a multiline string";
  };

  test_nixCanInterpolatePaths = let x = /nix;
  in {
    expr = null;
    expected = ./a/path/to/${x};
  };
}
