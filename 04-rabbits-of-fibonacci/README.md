# 04 · Rabbits of Fibonacci  ⭐⭐☆☆☆ (almost!)

> *A man puts a pair of rabbits in a place surrounded by walls. How many pairs of rabbits can be
> produced in a year, if each pair gives birth to a new pair every month, starting from the second
> month of their life?*
> — Leonardo of Pisa ("Fibonacci"), *Liber Abaci*, 1202

## The story

The question above is in a book that introduced the **Hindu-Arabic numerals** (0 to 9) to Europe.
Counting month after month, you get `1, 1, 2, 3, 5, 8, 13, 21, ...`: each number is the sum of the two
previous ones. Today we call it the **Fibonacci sequence**, and it appears in sunflower seeds,
pine cones, stock-market folklore and... in your programming exams.

The **definition** is beautiful and short:

```
F(0) = 0     F(1) = 1     F(n) = F(n-1) + F(n-2)
```

Writing it in Caml takes one minute. But there is a catch, and you are going to discover it with your own
eyes: the most natural program is **terribly slow**. Fixing it is today's real lesson.

Read more: [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_sequence) ·
[Liber Abaci](https://en.wikipedia.org/wiki/Liber_Abaci)

## Rules

Only `failwith` and `invalid_arg` are allowed. No `List` module. Use `invalid_arg` when `n < 0`.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `fib : int -> int` | the n-th Fibonacci number, **straight from the definition** (two recursive calls) |
| 2 | `fib_list : int -> int list` | the first `n` Fibonacci numbers: `fib_list 7 = [0; 1; 1; 2; 3; 5; 8]` |
| 3 | `fib_fast : int -> int` | same result as `fib`, but **fast** (only about `n` operations) |
| 4 | `sum_even_fibs : int -> int` | sum of the **even** Fibonacci numbers that are `<= limit` |

```ocaml
# fib 10;;
- : int = 55
# fib_list 10;;
- : int list = [0; 1; 1; 2; 3; 5; 8; 13; 21; 34]
# fib_fast 80;;
- : int = 23416728348467685
# sum_even_fibs 100;;
- : int = 44            (* 2 + 8 + 34 *)
```

### Feel the pain 🔥

Once `fib` works, type `fib 35;;` in utop and go grab a coffee. Then `fib 45;;`...
Why is it so slow? Draw the tree of calls for `fib 5`: how many times do you compute `fib 2`?

Then `fib_fast 80;;` answers instantly. The trick: don't *recompute*, **carry the two last values
along** as parameters of an inner function.

### A tiny puzzle

`sum_even_fibs 4_000_000` is a classic puzzle (it is Problem 2 of the
[Project Euler](https://projecteuler.net/) site). The tests check the answer, so you will know
immediately if you got it right!

## Test your code

```
cd 04-rabbits-of-fibonacci
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

(`examples.ml` only tests `fib` on small values on purpose, so that you can test it before fixing it.)

<details>
<summary>💡 Stuck? Click for a hint</summary>

For `fib_fast`, write an inner function `go a b k` where `a` and `b` are two **consecutive**
Fibonacci numbers and `k` is how many steps remain. At each step, `(a, b)` becomes `(b, a + b)`.
When `k = 0`, the answer is `a`.

`fib_list` can use the same trick, collecting `a` into a list at every step.

</details>

## Next up

**05 · Babbage's Engine**: functions that take functions. Welcome to *higher-order* land.
