{ mkDerivation, base, hspec, mit-license }:
mkDerivation {
  pname = "ghciwatch-bug-demo";
  version = "0.1.0.0";
  src = ./.;
  testHaskellDepends = [ base hspec ];
  doHaddock = false;
  description = "A simple haskell package to demonstrate a bug with ghciwatch";
  license = mit-license;
}
