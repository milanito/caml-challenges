# 11 · The Collatz Conjecture  ⭐⭐⭐⭐☆  (challenge)

> *"Mathematics may not be ready for such problems."*
> — Paul Erdős, about this conjecture

## The story

Pick any positive integer `n`.

- if `n` is **even**, divide it by 2;
- if `n` is **odd**, multiply it by 3 and add 1;
- repeat.

For example, starting at 6: `6 → 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1`.
And then you are stuck in the loop `1 → 4 → 2 → 1`.

The **Collatz conjecture** (1937) says that **whatever number you start with, you always end up at 1**.
Computers have checked it for every starting number up to about 2⁶⁸... but **nobody has a proof**.
It is one of the most famous unsolved problems in mathematics, and it is explained in one line to a
ten-year-old. 🤯

The sequences behave wildly. `27` takes **111 steps** and climbs as high as **9232** before falling
back to 1. Your mission: explore.

Read more: [Collatz conjecture](https://en.wikipedia.org/wiki/Collatz_conjecture)

## Rules

Only `failwith` and `invalid_arg` are allowed. No `List` module.
In the TD you wrote a function `loop` that applies a function until a predicate is true: it may inspire you.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `collatz_next : int -> int` | one step: `n/2` if `n` is even, `3n+1` if odd |
| 2 | `collatz_seq : int -> int list` | the whole sequence from `n` down to `1` (both included): `collatz_seq 6 = [6; 3; 10; 5; 16; 8; 4; 2; 1]`. Raises `Invalid_argument` if `n < 1` |
| 3 | `collatz_steps : int -> int` | the number of **steps** needed to reach 1 (`collatz_steps 6 = 8`, `collatz_steps 1 = 0`). Raises `Invalid_argument` if `n < 1`. *Do not build the list: just count!* |
| 4 | `collatz_peak : int -> int` | the **highest** value reached by the sequence |
| 5 | `longest_below : int -> int * int` | `longest_below limit` is the pair `(n, steps)` where `n` is the integer in `[1, limit-1]` that needs the most steps. If two integers tie, return the **smallest**. Raises `Invalid_argument` if `limit < 2` |

```ocaml
# collatz_seq 6;;
- : int list = [6; 3; 10; 5; 16; 8; 4; 2; 1]
# collatz_steps 27;;
- : int = 111
# collatz_peak 27;;
- : int = 9232
# longest_below 1000;;
- : int * int = (871, 178)
```

### 🏆 The big question

Which starting number **below 100 000** has the longest trajectory? The last test of `examples.ml`
knows the answer (and it is quick if you wrote `collatz_steps` without building lists).
Once you know the answer, ask yourself: *why can't a program ever prove the conjecture just by
testing numbers?*

## Test your code

```
cd 11-collatz
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `collatz_steps`: an inner function with the current value and a counter; stop when the value is 1.
- `collatz_peak`: same, carrying the maximum seen so far (no `max` function allowed: use an `if`).
- `longest_below`: a loop from 1 to `limit - 1`, carrying the best pair found so far.
  Replace the best pair only if the new number is **strictly** better (that gives you the "smallest on
  tie" rule for free).

</details>

## Next up

**12 · Roman Numerals**: translate between two number systems, using lists of couples.
