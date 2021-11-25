Zsh Framework Benchmark
=======================

This is a small utility to benchmark various Zsh frameworks. All of the frameworks are built with the instructions provided by the project README.md's.

To run, simply clone the repo and run `source run.zsh`.

The options are:
```
source run.zsh <options>
Options:
  -h              Show this help
  -k              Keep the frameworks (don't delete) after the tests are complete (default: delete)
  -p <path>       Set the path to where the frameworks should be 'installed' (default: results)
  -w <path>       Set the working directory (default: temp directory)
  -n <num>        Set the number of iterations to run for each framework (default: 100)
  -f <framework>  Select a specific framework to benchmark (default: all; can specify more than once)"
```

Benchmarks
----------

See the [Zim wiki 'Speed' page](https://github.com/zimfw/zimfw/wiki/Speed) for the latest benchmarks.
