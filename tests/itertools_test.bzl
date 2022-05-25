"""
Tests for the itertools package.
"""
load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load("//lib:itertools.bzl", it="itertools")


def _mul(x, y):
    return x * y


def _sub(x, y):
    return x - y


def _accumulate_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, actual=it.accumulate([]), expected=[])
    asserts.equals(env, actual=it.accumulate([1, 2, 3, 4, 5]), expected=[1, 3, 6, 10, 15])
    asserts.equals(env, actual=it.accumulate([1, 2, 3, 4, 5], initial=100),
                   expected=[100, 101, 103, 106, 110, 115])
    asserts.equals(env, actual=it.accumulate([1, 2, 3, 4, 5], _mul), expected=[1, 2, 6, 24, 120])
    asserts.equals(env, actual=it.accumulate([1, 2, 3, 4, 5], _sub), expected=[1, -1, -4, -8, -13])
    return unittest.end(env)


def _unique_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, [1, 2, 3], it._unique([1, 2, 3]))
    asserts.equals(env, [1, 2, 3], it._unique([1, 1, 2, 3, 2]))
    return unittest.end(env)


def _is_sorted_test_impl(ctx):
    env = unittest.begin(ctx)
    # Allow for repeated values.
    asserts.true(env, it._is_sorted([1, 2, 3], False))
    asserts.true(env, it._is_sorted([1, 2, 2, 3], False))
    asserts.false(env, it._is_sorted([1, 3, 2], False))

    # Strict sorting.
    asserts.true(env, it._is_sorted([1, 2, 3], True))
    asserts.false(env, it._is_sorted([1, 2, 2, 3], True))
    asserts.false(env, it._is_sorted([1, 3, 2], True))
    return unittest.end(env)


def _chain_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, actual=it.chain(["A", "B", "C"], ["D", "E", "F"]),
                   expected=["A", "B", "C", "D", "E", "F"])
    asserts.equals(env, actual=it.chain_from_iterable([[1, 2, 3], ["D", "E", "F"]]),
                   expected=[1, 2, 3, "D", "E", "F"])
    return unittest.end(env)


def _combinations_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[(1, 2), (1, 3), (2, 3)], actual=it.combinations([1, 2, 3], 2))
    return unittest.end(env)


def _combinations_with_replacement_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[(1, 1), (1, 2), (1, 3), (2, 2), (2, 3), (3, 3)],
                   actual=it.combinations_with_replacement([1, 2, 3], 2))
    return unittest.end(env)


def _compress_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=["A", "C", "E", "F"],
                   actual=it.compress(["A", "B", "C", "D", "E", "F"], [1, 0, 1, 0, 1, 1]))
    return unittest.end(env)


def _lt5_predicate(x):
        return x < 5


def _dropwhile_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[6, 4, 1],
                   actual=it.dropwhile(_lt5_predicate, [1, 4, 6, 4, 1]))
    return unittest.end(env)


def _is_odd(x):
    return bool(x % 2)


def _filterfalse_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, actual=it.filterfalse(_is_odd, range(10)), expected=[0, 2, 4, 6, 8])
    asserts.equals(env, actual=it.filterfalse(None, [None, False, True, 0, 1, "", "A"]),
                   expected=[None, False, 0, ""])
    return unittest.end(env)


def _groupby_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, actual=it.groupby([0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
                   expected=[(0, [0, 0, 0, 0]), (1, [1, 1, 1]), (2, [2, 2]), (3, [3])])
    asserts.equals(env, actual=it.groupby(range(10), _is_odd),
                   expected=[(False, [0, 2, 4, 6, 8]), (True, [1, 3, 5, 7, 9])])
    return unittest.end(env)


def _pairwise_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[(1, 2), (2, 3)], actual=it.pairwise([1, 2, 3]))
    return unittest.end(env)


def _permutations_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[(1, 2), (1, 3), (2, 1), (2, 3), (3, 1), (3, 2)],
                   actual=it.permutations([1, 2, 3], 2))
    return unittest.end(env)


def _product_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[(1, "a"), (1, "b"), (2, "a"), (2, "b")],
                   actual=it.product([1, 2], ["a", "b"]))
    asserts.equals(env, expected=[(1, 1), (1, 2), (2, 1), (2, 2)],
                   actual=it.product([1, 2], repeat=2))
    return unittest.end(env)


def _starmap_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, actual=it.starmap(_mul, [(2, 5), (3, 2), (10, 3)]), expected=[10, 6, 30])
    return unittest.end(env)


def _takewhile_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, actual=it.takewhile(_lt5_predicate, [1, 4, 6, 4, 1]), expected=[1, 4])
    return unittest.end(env)


def _zip_longest_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, actual=it.zip_longest(["A", "B", "C", "D"], ["x", "y"], fillvalue="-"),
                   expected=[("A", "x"), ("B", "y"), ("C", "-"), ("D", "-")])
    asserts.equals(env, actual=it.zip_longest([0, 1], [3, 4, 5]),
                   expected=[(0, 3), (1, 4), (None, 5)])
    return unittest.end(env)


_is_sorted_test = unittest.make(_is_sorted_test_impl)
_unique_test = unittest.make(_unique_test_impl)
accumulate_test = unittest.make(_accumulate_test_impl)
chain_test = unittest.make(_chain_test_impl)
combinations_test = unittest.make(_combinations_test_impl)
combinations_with_replacement_test = unittest.make(_combinations_with_replacement_test_impl)
compress_test = unittest.make(_compress_test_impl)
dropwhile_test = unittest.make(_dropwhile_test_impl)
filterfalse_test = unittest.make(_filterfalse_test_impl)
groupby_test = unittest.make(_groupby_test_impl)
pairwise_test = unittest.make(_pairwise_test_impl)
permutations_test = unittest.make(_permutations_test_impl)
product_test = unittest.make(_product_test_impl)
starmap_test = unittest.make(_starmap_test_impl)
takewhile_test = unittest.make(_takewhile_test_impl)
zip_longest_test = unittest.make(_zip_longest_test_impl)


def itertools_test_suite(name):
    unittest.suite(
        name,
        _is_sorted_test,
        _unique_test,
        accumulate_test,
        chain_test,
        combinations_test,
        combinations_with_replacement_test,
        compress_test,
        dropwhile_test,
        filterfalse_test,
        groupby_test,
        pairwise_test,
        permutations_test,
        product_test,
        starmap_test,
        takewhile_test,
        zip_longest_test,
    )
