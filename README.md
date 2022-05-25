# bazel-itertools [![CI pipeline](https://github.com/tillahoffmann/bazel-itertools/actions/workflows/main.yml/badge.svg)](https://github.com/tillahoffmann/bazel-itertools/actions/workflows/main.yml)

Functions for efficient looping matching python's [`itertools`](https://docs.python.org/3/library/itertools.html). These functions are convenient for generating targets, e.g. for hyperparameter search in machine learning or sensitivity analyses to test the robustness of scientific methods.

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

### Terminating on the shortest input sequence

- [x] [`accumulate(iterable, func, *, initial=None)`](https://docs.python.org/3/library/itertools.html#itertools.accumulate): Make an iterator that returns accumulated sums, or accumulated results of other binary functions (specified via the optional `func` argument).
- [x] [`chain(*iterables)`](https://docs.python.org/3/library/itertools.html#itertools.chain): Make an iterator that returns elements from the first iterable until it is exhausted, then proceeds to the next iterable, until all of the iterables are exhausted.
- [x] [`chain.from_iterable(iterable)`](https://docs.python.org/3/library/itertools.html#itertools.chain.from_iterable): Alternate constructor for `chain()`. Gets chained inputs from a single iterable argument that is evaluated lazily. _This function is implemented as `chain_from_iterable` because starlark does not support classes._
- [x] [`compress(data, selectors)`](https://docs.python.org/3/library/itertools.html#itertools.compress): Make an iterator that filters elements from `data` returning only those that have a corresponding element in `selectors` that evaluates to `True`. Stops when either the `data` or `selectors` iterables has been exhausted.
- [x] [`dropwhile(predicate, iterable)`](https://docs.python.org/3/library/itertools.html#itertools.dropwhile): Make an iterator that drops elements from the iterable as long as the predicate is true; afterwards, returns every element.
- [x] [`filterfalse(predicate, iterable)`](https://docs.python.org/3/library/itertools.html#itertools.filterfalse): Make an iterator that filters elements from `iterable` returning only those for which the `predicate` is `False`. If `predicate` is `None`, return the items that are false.
- [x] [`groupby(iterable, key=None)`](https://docs.python.org/3/library/itertools.html#itertools.groupby): Make an iterator that returns consecutive keys and groups from the `iterable`. The `key` is a function computing a key value for each element. If not specified or is `None`, `key` defaults to an identity function and returns the element unchanged. _This function differs from python's implementation because it does not require `iterable` to be pre-sorted by `key`. The result is not necessarily sorted by `key`._
- [ ] ~~[`islice(iterable, stop)` and `islice(iterable, start, stop[, step])`](https://docs.python.org/3/library/itertools.html#itertools.islice)~~: Make an iterator that returns selected elements from the `iterable`. _This function is not implemented because starlark does not support the concept of iterators, only finite sequences. Standard slicing can always be used._
- [x] [`pairwise(iterable)`](https://docs.python.org/3/library/itertools.html#itertools.pairwise): Return successive overlapping pairs taken from the input iterable.
- [x] [`starmap(function, iterable)`](https://docs.python.org/3/library/itertools.html#itertools.starmap): Make an iterator that computes the function using arguments obtained from the iterable.
- [x] [`takewhile(predicate, iterable)`](https://docs.python.org/3/library/itertools.html#itertools.takewhile): Make an iterator that returns elements from the `iterable` as long as the `predicate` is `True`.
- [ ] ~~[`tee(iterable, n=2)`](https://docs.python.org/3/library/itertools.html#itertools.tee)~~: Return `n` independent iterators from a single `iterable`. _This function is not implemented because starlark does not support the concept of iterators, only finite sequences. Sequences can always be reused without exhausting them._
- [x] [`zip_longest(*iterables, fillvalue=None)`](https://docs.python.org/3/library/itertools.html#itertools.zip_longest): Make an iterator that aggregates elements from each of the `iterables`. If the `iterables` are of uneven length, missing values are filled-in with `fillvalue`. Iteration continues until the longest iterable is exhausted.

### Combinatoric functions

- [x] [`product(*iterables, repeat=1)`](https://docs.python.org/3/library/itertools.html#itertools.product): Cartesian product of input iterables.
- [x] [`permutations(iterable, r=None)`](https://docs.python.org/3/library/itertools.html#itertools.permutations): Return successive `r` length permutations of elements in the `iterable`.
- [x] [`combinations(iterable, r)`](https://docs.python.org/3/library/itertools.html#itertools.combinations): Return `r` length subsequences of elements from the input `iterable`.
- [x] [`combinations_with_replacement(iterable, r)`](https://docs.python.org/3/library/itertools.html#itertools.combinations_with_replacement): Return `r` length subsequences of elements from the input `iterable` allowing individual elements to be repeated more than once.

### Infinite iterators

Infinite iterators are not supported because starlark does not support the concept of iterators, only finite sequences. Consequently, the following functions are not implemented.

- [ ] ~~[`count(start=0, step=1)`](https://docs.python.org/3/library/itertools.html#itertools.count)~~: Make an iterator that returns evenly spaced values starting with number start.
- [ ] ~~[`cycle(iterable)`](https://docs.python.org/3/library/itertools.html#itertools.cycle)~~: Make an iterator returning elements from the iterable and saving a copy of each. When the iterable is exhausted, return elements from the saved copy. Repeats indefinitely.
- [ ] ~~[`repeat(object[, times])`](https://docs.python.org/3/library/itertools.html#itertools.repeat)~~: Make an iterator that returns object over and over again. Runs indefinitely unless the `times` argument is specified.
