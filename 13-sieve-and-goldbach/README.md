# 13 · Sieve & Goldbach  ⭐⭐⭐⭐☆  (challenge)

> *"Every even integer greater than 2 is the sum of two primes."*
> — Christian Goldbach, in a letter to Leonhard Euler, 1742

## The story

**Eratosthenes** (c. 276–194 BC) was the head librarian of the Library of Alexandria, and he also measured
the circumference of the Earth with a stick and a shadow. 🌍 He also invented a way to find all prime
numbers: write the numbers from 2 to `n`, then repeat:

1. the first number that is not crossed out is **prime**: keep it;
2. cross out all its **multiples**.

```
2 3 4 5 6 7 8 9 10 11 12 13 ...
2 is prime  → cross out 4 6 8 10 12 ...
3 is prime  → cross out 9 15 21 ...
5 is prime  → cross out 25 35 ...
```

What is left are the primes. Beautiful, and perfectly suited to **lists and `filter`-like recursion**.

Then comes **Goldbach's conjecture**: `4 = 2+2`, `6 = 3+3`, `8 = 3+5`, `10 = 3+7 = 5+5`,
`100 = 3+97`... It has been checked by computers for every even number up to
**4 × 10¹⁸**, yet it has never been proven. Maybe *you* will find the first counterexample.
(Spoiler: no.) 😄

Read more: [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) ·
[Goldbach's conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture) ·
[Twin primes](https://en.wikipedia.org/wiki/Twin_prime)

## Rules

Only `failwith` and `invalid_arg` are allowed, plus the `@` operator. No `List` module.
`range` is given to you in `starter.ml` (you know it from exercise 01).

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `sieve : int list -> int list` | the sieve itself. **Given a list `p :: rest` of candidates** (all the integers from `2` on), keep `p`, remove the multiples of `p` from `rest`, and continue on what remains |
| 2 | `primes_upto : int -> int list` | all the primes `<= n` (`[]` if `n < 2`) |
| 3 | `goldbach : int -> int * int` | `goldbach n` is the pair `(p, q)` with `p + q = n`, both prime, and the **smallest possible `p`**. Raises `Invalid_argument` unless `n` is even and `>= 4` |
| 4 | `count_goldbach : int -> int` | in how many ways can `n` be written as `p + q` with `p <= q` both prime? (same condition on `n`) |
| 5 | `twin_primes : int -> (int * int) list` | all the pairs `(p, p+2)` of primes with `p + 2 <= n` |

```ocaml
# sieve (range 2 20);;
- : int list = [2; 3; 5; 7; 11; 13; 17; 19]
# primes_upto 30;;
- : int list = [2; 3; 5; 7; 11; 13; 17; 19; 23; 29]
# goldbach 100;;
- : int * int = (3, 97)
# count_goldbach 100;;
- : int = 6
# twin_primes 30;;
- : (int * int) list = [(3, 5); (5, 7); (11, 13); (17, 19)]
```

Note that `(29, 31)` is a pair of twin primes too, but `31 > 30`, so it is **not** in `twin_primes 30`.

### 🔎 Things to look for

- How many primes are there below 100? Below 1000? Below 10 000? (`1229`: the test knows.)
- Which even number below 100 has the *fewest* Goldbach decompositions? (Try `count_goldbach` on all of
  them, with your `range`.)

### 🤓 For the curious

The recursive "filter" version above is a famous and elegant program, but it is *not* the genuine sieve of
Eratosthenes: it divides by many numbers needlessly (it is closer to *trial division*). A 2009 paper by
Melissa O'Neill explains the difference: *"The Genuine Sieve of Eratosthenes"*.

## Test your code

```
cd 13-sieve-and-goldbach
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `sieve`: an inner function `remove_multiples p lst` (a filter that drops the elements divisible by `p`).
  Then `sieve (p :: rest) = p :: sieve (remove_multiples p rest)`.
- `goldbach n`: compute `primes_upto n` once. Walk through it: for each prime `p`, is `n - p` in the list?
  You will want a `mem` function (it is in exercise 02).
- `count_goldbach`: same walk, but only count while `p <= n - p`.
- `twin_primes`: walk through `primes_upto n` looking at two consecutive primes at a time.

</details>

## Next up

**14 · The Matrix Lab**: lists of lists, and a surprising way to compute Fibonacci numbers using...
a matrix power.
