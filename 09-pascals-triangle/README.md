# 09 · Pascal's Triangle  ⭐⭐⭐☆☆

## The story

In 1642, an 18-year-old named **Blaise Pascal** built a mechanical calculator, the *Pascaline*,
to help his father (a tax collector) add up endless columns of numbers.
A few years later he studied a triangle of numbers where **each number is the sum of the two numbers
above it**:

```
            1
           1 1
          1 2 1
         1 3 3 1
        1 4 6 4 1
      1 5 10 10 5 1
```

(Chinese, Indian and Persian mathematicians knew it centuries earlier. In China it is
*Yang Hui's triangle*.) The numbers in row `n` are the **binomial coefficients**: the number of ways
to choose `k` objects among `n`. And the programming language **Pascal** was named after Blaise. 🎓

The triangle hides many secrets: the sum of row `n` is `2^n`, the diagonals contain Fibonacci
numbers... and if you colour the **odd** numbers, a famous fractal appears. You'll see it at the end
of `examples.ml`. ✨

Read more: [Pascal's triangle](https://en.wikipedia.org/wiki/Pascal%27s_triangle) ·
[Pascal's calculator](https://en.wikipedia.org/wiki/Pascal%27s_calculator) ·
[Sierpinski triangle](https://en.wikipedia.org/wiki/Sierpi%C5%84ski_triangle)

## Rules

Only `failwith` and `invalid_arg` are allowed, plus the `@` operator. No `List` module.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `next_row : int list -> int list` | from one row of the triangle, compute the next one. Raises `Invalid_argument` on the empty list |
| 2 | `pascal : int -> int list list` | the first `n` rows (`pascal 0 = []`). Raises `Invalid_argument` if `n < 0` |
| 3 | `binomial : int -> int -> int` | `binomial n k`: *k among n*, read from the triangle. Raises `Invalid_argument` unless `0 <= k <= n` |

```ocaml
# next_row [1; 3; 3; 1];;
- : int list = [1; 4; 6; 4; 1]
# pascal 5;;
- : int list list = [[1]; [1; 1]; [1; 2; 1]; [1; 3; 3; 1]; [1; 4; 6; 4; 1]]
# binomial 5 2;;
- : int = 10
# binomial 20 10;;
- : int = 184756
```

### ✨ The surprise

When all the tests pass, `examples.ml` automatically prints the **odd entries** of the first 16 rows
as a triangle of stars. Try changing 16 to 32 or 64 (`print_sierpinski 64;;`).

## Test your code

```
cd 09-pascals-triangle
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

To go from `[1; 3; 3; 1]` to `[1; 4; 6; 4; 1]`, look at the *sums of consecutive pairs*:
`1+3 = 4`, `3+3 = 6`, `3+1 = 4`. Then put a `1` at each end. A function that matches
`a :: (b :: _ as rest)` produces those sums naturally.

For `pascal n`, an inner function can carry the current row and a counter.
For `binomial n k`, you need the `n`-th row (starting at 0) and its `k`-th element: you will want a
small `nth` helper (it is Exercise 1.4 of your lists TD).

</details>

## Next up

**10 · Merge Sort**: the algorithm designed in 1945 for the very first stored-program computers, and
the last "exam-level" exercise before the real challenges begin.
