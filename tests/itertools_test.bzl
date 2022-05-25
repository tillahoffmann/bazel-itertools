load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load("//lib:itertools.bzl", it="itertools")


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


def _combinations_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[(1, 2), (1, 3), (2, 3)], actual=it.combinations([1, 2, 3], 2))
    return unittest.end(env)


def _combinations_with_replacement_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[(1, 1), (1, 2), (1, 3), (2, 2), (2, 3), (3, 3)],
                   actual=it.combinations_with_replacement([1, 2, 3], 2))
    return unittest.end(env)


def _dropwhile_predicate(x):
        return x < 5


def _dropwhile_test_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(env, expected=[6, 4, 1],
                   actual=it.dropwhile(_dropwhile_predicate, [1, 4, 6, 4, 1]))
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


_is_sorted_test = unittest.make(_is_sorted_test_impl)
_unique_test = unittest.make(_unique_test_impl)
combinations_test = unittest.make(_combinations_test_impl)
combinations_with_replacement_test = unittest.make(_combinations_with_replacement_test_impl)
dropwhile_test = unittest.make(_dropwhile_test_impl)
pairwise_test = unittest.make(_pairwise_test_impl)
permutations_test = unittest.make(_permutations_test_impl)
product_test = unittest.make(_product_test_impl)


def itertools_test_suite(name):
    unittest.suite(
        name,
        _is_sorted_test,
        _unique_test,
        combinations_test,
        combinations_with_replacement_test,
        dropwhile_test,
        pairwise_test,
        permutations_test,
        product_test,
    )
