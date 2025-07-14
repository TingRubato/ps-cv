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
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            # Core development tools
            ruby
            pkgs.bundler
            pkgs.bundix
            
            # Other dependencies
            pkgs.imagemagick
            pkgs.nodejs
            pkgs.yarn
            pkgs.python3
            pkgs.python3Packages.nbconvert
            
            # System utilities
            pkgs.zlib
            pkgs.curl
            pkgs.git
            pkgs.procps
            pkgs.locale
          ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [ 
            pkgs.inotify-tools 
          ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ 
            pkgs.fswatch 
          ];

          shellHook = ''
            export LANG=en_US.UTF-8
            export LC_ALL=en_US.UTF-8
            export JEKYLL_ENV=development
            export EXECJS_RUNTIME=Node
            
            # Set up Ruby environment
            export GEM_HOME="$PWD/.gems"
            export GEM_PATH="$GEM_HOME"
            export PATH="$GEM_HOME/bin:$PATH"
            
            echo "✔️  Welcome to ps-cv dev environment."
            echo ""
            echo "🔧 Setup instructions:"
            echo "   1. Run 'bundle install' to install Ruby gems"
            echo "   2. Run 'npm install' to install Node dependencies"
            echo ""
            echo "🚀 Development commands:"
            echo "   • 'bundle exec jekyll serve' - Start Jekyll dev server"
            echo "   • 'bundle exec jekyll build' - Build the site"
            echo ""
            
            # Create .gems directory if it doesn't exist
            mkdir -p .gems
          '';
        };
      }
    );
}