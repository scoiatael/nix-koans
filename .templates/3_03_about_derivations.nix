{ lib, pkgs, ... }:

{
  # one last missing puzzle block in building software is to actually compile the thing
  # as you might've noticed nix doesn't have "exec" or "eval" to shell out
  # instead we build "derivations"
  test_nixHasDerivations = {
    expr = null;
    expected = (derivation {
      name = "myname";
      builder = "${pkgs.coreutils}/bin/true";
      system = builtins.currentSystem;
    }).outPath;
  };

  # sadly, if you take a look at ^ that outPath, there's nothing there!
  # ls /nix/store/q4wj2ri7d2rvwv79by6vrgvyr32m3pna-myname
  # "/nix/store/q4wj2ri7d2rvwv79by6vrgvyr32m3pna-myname": No such file or directory (os error 2)

  # in order to make it happen we need to force "instantiation" of a derivation
  # +----------------------+             +------------------------+
  # | Nix evaluator        |             | Nix store              |
  # |  .----------------.  |             |                        |
  # |  | Nix expression |  |             |                        |
  # |  '----------------'  |             |                        |
  # |          |           |             |                        |
  # |       evaluate       |             |                        |
  # |          |           |             |                        |
  # |          V           |             |                        |
  # |    .------------.    |             |  .------------------.  |
  # |    | derivation |----|-instantiate-|->| store derivation |  |
  # |    '------------'    |             |  '------------------'  |
  # |                      |             |           |            |
  # |                      |             |        realise         |
  # |                      |             |           |            |
  # |                      |             |           V            |
  # |  .----------------.  |             |    .--------------.    |
  # |  | Nix expression |<-|----read-----|----| store object |    |
  # |  '----------------'  |             |    '--------------'    |
  # |          |           |             |                        |
  # |       evaluate       |             |                        |
  # |          |           |             |                        |
  # |          V           |             |                        |
  # |    .------------.    |             |                        |
  # |    |   value    |    |             |                        |
  # |    '------------'    |             |                        |
  # +----------------------+             +------------------------+
  # https://nixos.org/manual/nix/stable/language/import-from-derivation.html
  # Please note that this is an advanced feature used here to showcase derivation mechanism.
  # As you'll see in the next chapter, in day-to-day usage instantiation is usually performed outside of nix expressions
  test_nixCanBuildDerivations = let
    myname = derivation {
      name = "hello";
      builder = "${pkgs.dash}/bin/dash";
      args = [ "-c" "${pkgs.coreutils}/bin/echo -n hello > $out" ];
      system = builtins.currentSystem;
    };
  in {
    expr = null;
    expected = builtins.readFile myname;
  };

  # armed with that knowledge we can finally proceed to some real-life nix in chapter 4.
}
