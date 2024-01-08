{ lib, pkgs, ... }:

# We can also download sources from the internet
{
  test_nixCanDownloadURL = {
    expr = null;
    expected = builtins.fetchurl
      "https://github.com/scoiatael/nix-koans/archive/0cf542b7a425ed73b71704f8d175a4eb128d7b27.tar.gz";
  };

  test_nixCanDownloadTarball = {
    expr = null;
    expected = builtins.fetchTarball
      "https://github.com/scoiatael/nix-koans/archive/0cf542b7a425ed73b71704f8d175a4eb128d7b27.tar.gz";
  };

  test_nixCanDownloadGit = {
    expr = null;
    expected = (builtins.fetchGit {
      url = "https://github.com/scoiatael/nix-koans/";
      rev = "0cf542b7a425ed73b71704f8d175a4eb128d7b27";
    }).outPath;
  };

  # take a look at these paths
  # did you notice any differences between these?

  # nixpkgs has even more helpers:
  test_nixpkgsHasFetchGithub = {
    expr = null;
    expected = builtins.toPath (pkgs.fetchFromGitHub {
      owner = "scoiatael";
      repo = "nix-koans";
      rev = "0cf542b7a425ed73b71704f8d175a4eb128d7b27";
      hash = "sha256-mks7rYtnAusgp8gah6HCfwLSS+dq0hDCwgPxPVSeRiU=";
    });
  };
  # if you ever need to decide, use the last one - it verifies the hash of downloaded path and is the nicest to use.

}
