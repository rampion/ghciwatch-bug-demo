{
  description = "A simple haskell package to demonstrate a bug with ghciwatch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ghciwatch.url = "github:MercuryTechnologies/ghciwatch?ref=v0.5.8";
  };

  outputs = { self, nixpkgs, ghciwatch }: 
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
        haskellPackages = pkgs.haskellPackages;
        ghciwatch-bug-demo = import ./default.nix {
          mkDerivation = pkgs.stdenv.mkDerivation;
          base = haskellPackages.base;
          hspec = haskellPackages.hspec;
          mit-license = pkgs.lib.licenses.mit;
        };
    in
    {
      packages.x86_64-linux.ghciwatch-bug-demo = ghciwatch-bug-demo;
      defaultPackage.x86_64-linux = ghciwatch-bug-demo;
      checks = self.packages;
      devShell.x86_64-linux = haskellPackages.shellFor {
        packages = p: [];
        buildInputs = [
          haskellPackages.ghcid
          haskellPackages.cabal-install
          ghciwatch.packages.x86_64-linux.ghciwatch
        ];

        shellHook = "export PS1='\\e[1;34mdev > \\e[0m'";

        name="ghciwatch-bug-demo";
      };
    };
}
