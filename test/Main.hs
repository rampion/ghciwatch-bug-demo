{-# LANGUAGE BlockArguments #-}
module Main (main) where

import GhciwatchBugDemo (unit)
import Test.Hspec

main :: IO ()
main = hspec do
  it "has unit" do
    unit `shouldBe` ()
