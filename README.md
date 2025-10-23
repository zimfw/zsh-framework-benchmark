Zsh Framework Benchmark
=======================

This is a small utility to benchmark various Zsh frameworks. All of the frameworks are built with the instructions provided by the project README.md's.

To run, simply clone the repo and run `source run.zsh`.

The options are:
```
source run.zsh <options>
Options:
  -h              Show this help
  -k              Keep the frameworks after the tests are complete (default: delete)
  -p <path>       Set the path to where the frameworks should be installed (default: results)
  -w <path>       Set the working directory (default: temp directory)
  -n <number>     Set the number of iterations to run for each framework (default: 100)
  -f <framework>  Specify framework to benchmark (default: all; can specify more than once)
```

Requirements
------------

The [expect](https://core.tcl-lang.org/expect/index) command.

Benchmarks
----------

See the [Zim Framework wiki 'Speed' page](https://github.com/zimfw/zimfw/wiki/Speed) for the latest benchmarks.
