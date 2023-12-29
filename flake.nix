{
  description = "Koans for learning nix language. Red, green, refactor :)";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  outputs = inputs@{ self, flake-parts, devshell, nixpkgs }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ devshell.flakeModule ];

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "i686-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = { pkgs, ... }: {
        devshells.default = {
          commands = [{
            name = "check";
            command = ''
              nix eval --impure --expr 'import ./templates/test.nix {}'
            '';
          }];
        };
      };
    };
}
