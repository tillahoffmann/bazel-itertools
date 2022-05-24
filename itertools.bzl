"""
Functions for efficient looping matching python's `itertools`.
See https://docs.python.org/3/library/itertools.html for details.
"""


def _unique(values):
    unique_values = []
    for value in values:
        if value not in unique_values:
            unique_values.append(value)
    return unique_values


def _is_sorted(values, strict):
    for a, b in pairwise(values):
        if (strict and b <= a) or (not strict and b < a):
            return False
    return True


def pairwise(iterable):
    previous = None
    result = []
    for i, value in enumerate(iterable):
        if i > 0:
            result.append((previous, value))
        previous = value
    return result


def product(*args, repeat=1):
    """
    Cartesian product of input iterables.

    Args:
        *args: Input iterables to form a Cartesian product.
        repeat: Number of times to repeat input iterables.

    Returns:
        product: Cartesian product of input iterables.
    """
    pools = [tuple(pool) for pool in args] * repeat
    result = [[]]
    for pool in pools:
        result = [x + [y] for x in result for y in pool]
    return [tuple(x) for x in result]


def permutations(iterable, r=None):
    pool = tuple(iterable)
    n = len(pool)
    r = n if r == None else r
    return [values for values in product(pool, repeat=r) if len(_unique(values)) == r]


def _combinations(iterable, r, with_replacement=False):
    pool = tuple(iterable)
    n = len(pool)
    return [
        tuple([pool[i] for i in indices]) for indices in product(range(n), repeat=r) if
        _is_sorted(indices, not with_replacement)
    ]


def _combinations_with_replacement(iterable, r):
    return _combinations(iterable, r, with_replacement=True)


itertools = struct(
    _is_sorted=_is_sorted,
    _unique=_unique,
    combinations=_combinations,
    combinations_with_replacement=_combinations_with_replacement,
    pairwise=pairwise,
    permutations=permutations,
    product=product,
)
