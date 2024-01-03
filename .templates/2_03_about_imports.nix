{ pkgs, ... }:

{
  test_nixCanImportOtherFiles = {
    expr = null;
    expected = import ./an_imported_file.nix;
  };

  test_importedFilesAreJustExpressions = {
    expr = null;
    expected = "1" + import ./an_imported_string.nix;
  };

  test_importsCanReferToChannels = {
    expr = null;
    # id is "identity": https://teu5us.github.io/nix-lib.html#lib.trivial.id
    expected = with (import <nixpkgs> { }).lib.trivial; id 1;
  };

  test_butMoreCommonIsPassingNixpkgsAsArg = {
    expr = null;
    expected = with pkgs.lib.trivial; id 1;
  };
}
