# 14 · The Matrix Lab  ⭐⭐⭐⭐☆  (challenge)

## The story

A **matrix** is a rectangular table of numbers. Mathematicians like **Arthur Cayley** (1858) and
**James Sylvester** (who coined the word) showed that tables of numbers can be *added*, *multiplied*,
*inverted*... and that this algebra describes rotations of 3D objects, the equations of physics, Google's
original PageRank, neural networks (including the ones that power AI assistants), and much more. 🧠

In Caml, a matrix is naturally a **list of rows**, each row being a list of numbers:

```
 1 2 3        [ [1; 2; 3];
 4 5 6    =      [4; 5; 6] ]
```

Multiplying matrices is the heart of the exercise. The rule: the entry in row `i`, column `j` of `A × B` is the
**dot product** of row `i` of `A` with column `j` of `B`:

```
(1 2 3)   (7  8)         1×7 + 2×9 + 3×11 = 58     1×8 + 2×10 + 3×12 = 64
(4 5 6) × (9 10)    =    4×7 + 5×9 + 6×11 = 139    4×8 + 5×10 + 6×12 = 154
          (11 12)
```

And then, a **magic trick** that connects to exercise 04: the matrix `[[1; 1]; [1; 0]]` raised to the power `n`
contains the Fibonacci numbers! ✨

Read more: [Matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication) ·
[Arthur Cayley](https://en.wikipedia.org/wiki/Arthur_Cayley) ·
[Fibonacci and matrices](https://en.wikipedia.org/wiki/Fibonacci_sequence#Matrix_form)

## Rules

Only `failwith` and `invalid_arg` are allowed, plus the `@` operator. No `List` module.
You may assume matrices are **rectangular** (all rows have the same length).

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `transpose : 'a list list -> 'a list list` | swap rows and columns: `transpose [[1;2;3];[4;5;6]] = [[1;4];[2;5];[3;6]]`. `transpose [] = []` |
| 2 | `dot : int list -> int list -> int` | dot product of two vectors. Raises `Invalid_argument` if the lengths differ |
| 3 | `mat_mul : int list list -> int list list -> int list list` | matrix product. Raises `Invalid_argument` if the sizes are incompatible. *Hint: `transpose` turns columns into rows* |
| 4 | `identity : int -> int list list` | the `n × n` identity matrix (`1` on the diagonal, `0` elsewhere). `identity 0 = []` |
| 5 | `mat_pow : int list list -> int -> int list list` | `mat_pow m k` is `m` multiplied `k` times by itself (a **square** matrix). `k = 0` gives the identity. Raises `Invalid_argument` if `k < 0` |
| 6 | `fib_matrix : int -> int` | the n-th Fibonacci number, computed with `mat_pow [[1; 1]; [1; 0]] n` (look at which entry of the result is `F(n)`: the tests will tell you if you are wrong) |
| 7 | `rotate_cw : 'a list list -> 'a list list` | rotate a matrix a quarter turn **clockwise** |

```ocaml
# mat_mul [[1;2;3];[4;5;6]] [[7;8];[9;10];[11;12]];;
- : int list list = [[58; 64]; [139; 154]]
# mat_pow [[1;1];[1;0]] 10;;
- : int list list = [[89; 55]; [55; 34]]
# fib_matrix 50;;
- : int = 12586269025
# rotate_cw [[1;2;3];[4;5;6]];;
- : int list list = [[4; 1]; [5; 2]; [6; 3]]
```

### 🚀 Make it fast (optional but beautiful)

Computing `m^1000` with 1000 multiplications is silly. Use *exponentiation by squaring*:
`m^10 = (m^5)²` and `m^5 = m × m^4`: only about `log₂ k` multiplications.
(With `fib_matrix`, remember that `int` values are 63 bits: beyond `F(90)` they overflow, but `F(80)` is safe.)

### 🖼️ Rotating a picture

At the end of `examples.ml`, the letter F is drawn as a list of rows of characters, then rotated four times
with *your* `rotate_cw`. After four quarter turns, you must get your F back.

## Test your code

```
cd 14-matrix-lab
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `transpose`: the first row of the result is made of the **first element of every row**; the rest is the
  transpose of the **tails** of every row. Two small helpers `heads` and `tails` make it very clean.
  Stop when the rows are empty.
- `mat_mul a b`: compute `transpose b` once. Each row of the answer is made by taking a row `r` of `a`
  and computing `dot r c` for every column `c`.
- `rotate_cw`: transpose, then reverse every row.

</details>

## Next up

**15 · All the Ways**: subsets, permutations, combinations, and the famous salesman who wants to visit
every city.
