# bazel-itertools [![CI pipeline](https://github.com/tillahoffmann/bazel-itertools/actions/workflows/main.yml/badge.svg)](https://github.com/tillahoffmann/bazel-itertools/actions/workflows/main.yml)

Functions for efficient looping matching python's [`itertools`](https://docs.python.org/3/library/itertools.html).

## Usage

First, add the following lines to your `WORKSPACE` file to download the `bazel-itertools` functions.

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "bazel_itertools",
    url = "https://github.com/tillahoffmann/bazel-itertools/archive/refs/tags/[VERSION].tar.gz",
    strip_prefix = "bazel-itertools-[VERSION]",
    # sha256 = "[add for peace of mind]",
)
```

Second, load the functions and use them, e.g. in a `BUILD` file.

```python
load("@bazel_itertools//lib:itertools.bzl", "itertools")

print(itertools.combinations([1, 2, 3], 2))
# [(1, 2), (1, 3), (2, 3)]
```

## Functions

### Infinite iterators

Infinite iterators are not supported because Starlark programs are [guaranteed to halt](https://github.com/bazelbuild/starlark/blob/master/spec.md#for-loops). Consequently, the following functions are not implemented.

- [ ] [`count(start=0, step=1)`](https://docs.python.org/3/library/itertools.html#itertools.count): Make an iterator that returns evenly spaced values starting with number start.
- [ ] [`cycle(iterable)`](https://docs.python.org/3/library/itertools.html#itertools.cycle): Make an iterator returning elements from the iterable and saving a copy of each. When the iterable is exhausted, return elements from the saved copy. Repeats indefinitely.
- [ ] [`repeat(object[, times])`](https://docs.python.org/3/library/itertools.html#itertools.repeat): Make an iterator that returns object over and over again. Runs indefinitely unless the `times` argument is specified.

### Terminating on the shortest input sequence

- [ ] [`accumulate(iterable[, func, *, initial=None])`](https://docs.python.org/3/library/itertools.html#itertools.accumulate): Make an iterator that returns accumulated sums, or accumulated results of other binary functions (specified via the optional `func` argument).
- [x] [`pairwise(iterable)`](https://docs.python.org/3/library/itertools.html#itertools.pairwise): Return successive overlapping pairs taken from the input iterable.


### Combinatoric functions

- [x] [`product(*iterables, repeat=1)`](https://docs.python.org/3/library/itertools.html#itertools.product): Cartesian product of input iterables.
- [x] [`permutations(iterable, r=None)`](https://docs.python.org/3/library/itertools.html#itertools.permutations): Return successive `r` length permutations of elements in the `iterable`.
- [x] [`combinations(iterable, r)`](https://docs.python.org/3/library/itertools.html#itertools.combinations): Return `r` length subsequences of elements from the input `iterable`.
- [x] [`combinations_with_replacement(iterable, r)`](https://docs.python.org/3/library/itertools.html#itertools.combinations_with_replacement): Return `r` length subsequences of elements from the input `iterable` allowing individual elements to be repeated more than once.
