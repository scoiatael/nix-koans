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
              #!/usr/bin/env ruby

              require 'json'
              require 'ruby-progressbar'

              report = `nix eval --impure --expr 'import ./templates/test.nix {}' --json`
              doc = JSON.parse! report
              passed, failed = doc.partition { |k, v| v.empty? }
              pb = ProgressBar.create(title: "Your progress", starting_at: passed.size, total: doc.size, format: "%t (%c/%C) [%B]")
              pb.stop

              if f = failed.first
                fname = Dir["templates/#{f.first}*"].first
                lines = File.read(fname).lines.each.with_index(1).to_a
                names = f.last.map { |x| x["name"] }
                line = names.map { |n| lines.select { |l, ln| l.include? n }.first&.last }.min
                puts "Medidate on #{fname}" + if line then ":#{line}" else "" end
              end
            '';
          }];

          packages =
            [ (pkgs.ruby_3_3.withPackages (ps: [ ps.ruby-progressbar ])) ];
        };
      };
    };
}
