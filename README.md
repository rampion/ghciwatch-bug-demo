Demo of an odd interaction between hspec's `--color` flag and ghciwatch.

When running without `--color`, tests are rerun when files in the `test/`
directory are changed.  For example, if we start `ghciwatch`, wait five seconds,
and then use `sed` to edit the test file, the tests are rerun:

```
dev > make test-without-color
git restore test/Main.hs
{ sleep 5; echo "cuing rerun"; sed -i "s/has unit/has a unit/" test/Main.hs; } &
ghciwatch --command 'cabal repl ghciwatch-bug-demo-test' --after-startup-ghci 'import System.Environment (withArgs)' --test-ghci 'withArgs ["--match=unit"] main' --watch test
Build profile: -w ghc-9.4.8 -O1
In order, the following will be built (use -v for more details):
 - ghciwatch-bug-demo-0.1.0.0 (test:ghciwatch-bug-demo-test) (first run)
Preprocessing test suite 'ghciwatch-bug-demo-test' for ghciwatch-bug-demo-0.1.0.0..
GHCi, version 9.4.8: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( test/Main.hs, interpreted )
Ok, one module loaded.
• Running after-startup command command=import System.Environment (withArgs)
• All good! Finished starting up in 207.45ms
• Running test command command=withArgs ["--match=unit"] main

has unit [✔]

Finished in 0.0001 seconds
1 example, 0 failures
• Finished running tests in 3.96ms
cuing rerun

• Reloading ghci:
  • test/Main.hs

[1 of 2] Compiling Main             ( test/Main.hs, interpreted ) [Source file changed]
Ok, one module loaded.
• All good! Finished reloading in 11.00ms
• Running test command command=withArgs ["--match=unit"] main

has a unit [✔]

Finished in 0.0001 seconds
1 example, 0 failures
• Finished running tests in 4.55ms
^C
dev >
```

Adding a `--color` flag, for some reason, prevents `ghciwatch` from rerunning
the tests. Note that nothing happens after "cuing rerun", and when we force quit
with `CTRL-C` we get an error message.

```
dev > make test-with-color
git restore test/Main.hs
{ sleep 5; echo "cuing rerun"; sed -i "s/has unit/has a unit/" test/Main.hs; } &
ghciwatch --command 'cabal repl ghciwatch-bug-demo-test' --after-startup-ghci 'import System.Environment (withArgs)' --test-ghci 'withArgs ["--match=unit", "--color"] main' --watch test
Build profile: -w ghc-9.4.8 -O1
In order, the following will be built (use -v for more details):
 - ghciwatch-bug-demo-0.1.0.0 (test:ghciwatch-bug-demo-test) (first run)
Preprocessing test suite 'ghciwatch-bug-demo-test' for ghciwatch-bug-demo-0.1.0.0..
GHCi, version 9.4.8: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( test/Main.hs, interpreted )
Ok, one module loaded.
• Running after-startup command command=import System.Environment (withArgs)
• All good! Finished starting up in 202.82ms
• Running test command command=withArgs ["--match=unit", "--color"] main

has unit [✔]

Finished in 0.0001 seconds
1 example, 0 failures
cuing rerun
^C
• Reloading ghci:
  • test/Main.hs

Error:   × Tasks failed:
  │ • run_ghci: channel closed

make: *** [Makefile:9: test-with-color] Error 1
dev >
```
