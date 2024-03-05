test-without-color:
	git restore test/Main.hs
	{ sleep 5; echo "cuing rerun"; sed -i "s/has unit/has a unit/" test/Main.hs; } &
	ghciwatch --command 'cabal repl ghciwatch-bug-demo-test' --after-startup-ghci 'import System.Environment (withArgs)' --test-ghci 'withArgs ["--match=unit"] main' --watch test

test-with-color:
	git restore test/Main.hs
	{ sleep 5; echo "cuing rerun"; sed -i "s/has unit/has a unit/" test/Main.hs; } &
	ghciwatch --command 'cabal repl ghciwatch-bug-demo-test' --after-startup-ghci 'import System.Environment (withArgs)' --test-ghci 'withArgs ["--match=unit", "--color"] main' --watch test
