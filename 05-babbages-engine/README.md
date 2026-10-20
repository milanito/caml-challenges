# 05 · Babbage's Engine  ⭐⭐☆☆☆

> *"I wish to God these calculations had been executed by steam."*
> — Charles Babbage, c. 1821 (looking at error-filled mathematical tables)

## The story

Before calculators, navigators and engineers relied on printed **tables** (logarithms, sines...).
They were computed by hand, and full of mistakes, and some mistakes cost ships.
So **Charles Babbage** designed the **Difference Engine**: a giant brass machine that tabulates
polynomials using **only additions**, thanks to the *method of finite differences*:

```
n²+n+41 :   41   43   47   53   61   71   83      <- the values
               2    4    6    8   10   12          <- differences
                 2    2    2    2    2             <- differences of the differences: CONSTANT!
```

For a polynomial of degree 2, the second differences are constant. The engine just keeps adding
the constants back up. No multiplication needed!

And look at `n² + n + 41`: this is **Euler's prime-generating polynomial**. It gives a prime number for
every `n` from 0 to 39. 🤯 (You will check it.)

In this exercise you build a small "engine" out of **higher-order functions**:
functions that take other functions as arguments (or return them).

Read more: [Difference engine](https://en.wikipedia.org/wiki/Difference_engine) ·
[Finite differences](https://en.wikipedia.org/wiki/Finite_difference) ·
[Prime-generating polynomial](https://en.wikipedia.org/wiki/Formula_for_primes#Prime-generating_polynomials)

## Rules

Only `failwith` and `invalid_arg`. No `List` module.
Use `invalid_arg` when a count is negative.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `twice : ('a -> 'a) -> 'a -> 'a` | `twice f x` is `f (f x)` |
| 2 | `compose : ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c` | `compose f g x` is `f (g x)` |
| 3 | `iterate : ('a -> 'a) -> int -> 'a -> 'a` | `iterate f n x` applies `f` to `x`, `n` times. `iterate f 0 x = x`. Raises `Invalid_argument` if `n < 0` |
| 4 | `tabulate : (int -> 'a) -> int -> 'a list` | `tabulate f n` is `[f 0; f 1; ...; f (n-1)]` (a *table* of `n` values). Raises `Invalid_argument` if `n < 0` |
| 5 | `differences : int list -> int list` | differences of consecutive elements: `differences [41; 43; 47; 53] = [2; 4; 6]` |

```ocaml
# twice (fun x -> x * x) 3;;
- : int = 81
# compose (fun x -> x + 1) (fun x -> x * 2) 5;;
- : int = 11
# iterate (fun s -> s ^ "!") 3 "hey";;
- : string = "hey!!!"
# let poly n = n * n + n + 41;;
# tabulate poly 7;;
- : int list = [41; 43; 47; 53; 61; 71; 83]
# iterate differences 2 (tabulate poly 7);;
- : int list = [2; 2; 2; 2; 2]
```

That last line is Babbage's whole idea in one expression. ✨

### Brain teaser 🧠

What does `twice twice (fun x -> x + 1) 0` return? Guess first, run it second, then explain
why to your teammates. (The test file checks your answer.)

## Test your code

```
cd 05-babbages-engine
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `compose f g` can return an anonymous function: `fun x -> ...` (or `function x -> ...`).
- `iterate`: if `n = 0` return `x`, otherwise apply `f` once and iterate `n - 1` more times.
- `tabulate`: an inner function `go i` that builds `[f i; f (i+1); ...]` and stops at `n`.
- `differences`: match on **two** elements at once: `a :: (b :: _ as rest)`.

</details>

## Next up

**06 · Caesar's Secret**: you made it through the warm-up. Now the exam-level exercises begin,
and the first one hides a secret message... 🕵️
