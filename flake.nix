{
  description = "Development environment for ps-cv (Jekyll, Ruby, Node, Python)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        ruby = pkgs.ruby_3_1;

        # Only try to use gemset.nix if it exists, otherwise fail gracefully
        gemsetPath = builtins.pathExists ./gemset.nix;
        gemset = if gemsetPath then
          pkgs.bundlerEnv {
            name = "ps-cv-gems";
            ruby = ruby;
            gemdir = ./.;
          }
        else
          pkgs.runCommand "missing-gemset" {} ''
            echo "ERROR: gemset.nix is missing. Please run 'bundix' to generate it from Gemfile.lock."
            exit 1
          '';

      in {
        devShells.default = pkgs.mkShell {
          buildInputs =
            [
              gemset
              pkgs.imagemagick
              pkgs.nodejs
              pkgs.yarn
              pkgs.python3
              pkgs.python3Packages.nbconvert
            ]
            ++ pkgs.lib.optionals pkgs.stdenv.isLinux [ pkgs.inotify-tools ]
            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.fswatch ]
            ++ [
              pkgs.zlib
              pkgs.curl
              pkgs.git
              pkgs.procps
              pkgs.locale
              pkgs.bundix
            ];

          shellHook = ''
            export LANG=en_US.UTF-8
            export LC_ALL=en_US.UTF-8
            export JEKYLL_ENV=development
            export EXECJS_RUNTIME=Node

            if ! command -v bundix >/dev/null 2>&1; then
              echo "❌ 'bundix' is not installed or not in PATH. Please install it (e.g., with 'nix profile install nixpkgs#bundix') before continuing."
              return 1
            fi

            if [ ! -f ./gemset.nix ]; then
              echo "⚠️  gemset.nix is missing. Please run 'bundix' to generate it from Gemfile.lock."
            fi

            if [ -f ./Gemfile.lock ] && [ ! -f ./gemset.nix ]; then
              echo "Attempting to generate gemset.nix from Gemfile.lock using bundix..."
              bundix || {
                echo "❌ Failed to run bundix. Please ensure bundix is installed and try again."
                return 1
              }
            fi

            echo "✔️  Welcome to ps-cv dev environment."
            echo "👉 Run 'bundle install' to install Ruby gems."
            echo "👉 Run 'npm install' to install Node dependencies."
          '';
        };
      }
    );
}