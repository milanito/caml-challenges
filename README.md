# 🐫 20 Caml Challenges

Twenty programming exercises in **Caml / OCaml**, from "warm-up" to "final boss", for first-year students (Info-sup).
Each one comes with a bit of history, examples, and a **test file** that tells you immediately what works.

> Algorithms are older than computers, and so are most of the ideas in this repository:
> Ada Lovelace, Babbage, Caesar, Euclid, Gauss, Turing... you will meet them all.

## How it works

Each folder contains:

| File | Purpose |
|------|---------|
| `README.md` | the story, the exercise, examples and (hidden) hints |
| `starter.ml` | the functions to write, with the right names and types. Replace each `failwith "TODO"` |
| `examples.ml` | the tests. **Do not edit it.** |

### Working in groups of 4

1. Open the folder of the exercise, read the `README.md` **together**.
2. Write your functions in `starter.ml` with your favourite editor (you can split the functions between you).
3. Test in `utop`, from inside the folder of the exercise:

```
cd 05-babbages-engine
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

You will see something like:

```
[ OK ] twice (fun x -> x + 1) 0 = 2
[FAIL] compose gives f after g
...
17/20 checks passed
```

When you see `Perfect!`, you are done: go to the next one. You do not need to read or open any file in Caml,
`#use` does it for you.

If your code does not compile, `utop` shows the error and the position. Fix it and `#use "starter.ml";;` again.

### The rules (unless the exercise says otherwise)

- Only `failwith` and `invalid_arg` are predefined functions you can use (plus the `@` operator).
- **No `List` module**: write your own functions. (That is the whole point!)
- Functions must be **correct for every input**, not only the examples.
- Raise the exception the exercise asks for. Test the edge cases (empty list, 0, negative numbers...).
- Helper functions are welcome, and encouraged.

### Suggested team roles

Rotate on each exercise: **keyboard** (types), **reviewer** (reads each line and looks for edge cases),
**tester** (tries things in `utop`), **spokesperson** (explains the group's solution). 

## The exercises

| # | Exercise | Difficulty | You will practise |
|---|----------|:---------:|-------------------|
| 01 | [Ada's Notes](01-adas-notes) | ⭐ | recursion on lists, `sum`, `length`, `last` |
| 02 | [Hopper's Bug](02-hoppers-bug) | ⭐ | searching, positions, removing, exceptions |
| 03 | [The Faro Shuffle](03-faro-shuffle) | ⭐ | `take`, `drop`, splitting and interleaving lists |
| 04 | [Rabbits of Fibonacci](04-rabbits-of-fibonacci) | ⭐⭐ | double recursion, accumulators, efficiency |
| 05 | [Babbage's Engine](05-babbages-engine) | ⭐⭐ | functions as values, `compose`, `iterate` |
| 06 | [Caesar's Secret](06-caesar-cipher) | ⭐⭐⭐ | characters, ciphers, codebreaking |
| 07 | [The Fax Machine](07-fax-machine-rle) | ⭐⭐⭐ | run-length encoding, lists of couples |
| 08 | [Unix Text Tools](08-unix-text-tools) | ⭐⭐⭐ | words, duplicates, `wc` |
| 09 | [Pascal's Triangle](09-pascals-triangle) | ⭐⭐⭐ | lists of lists, binomials, fractals |
| 10 | [Merge Sort](10-merge-sort) | ⭐⭐⭐⭐ | divide and conquer |
| 11 | [The Collatz Conjecture](11-collatz) | ⭐⭐⭐⭐ | an unsolved problem |
| 12 | [Roman Numerals](12-roman-numerals) | ⭐⭐⭐⭐ | conversion both ways |
| 13 | [Sieve & Goldbach](13-sieve-and-goldbach) | ⭐⭐⭐⭐ | primes, Eratosthenes |
| 14 | [The Matrix Lab](14-matrix-lab) | ⭐⭐⭐⭐ | matrices as lists of lists |
| 15 | [All the Ways](15-all-the-ways) | ⭐⭐⭐⭐ | subsets, permutations, the travelling salesman |
| 16 | [Cellular Automata](16-cellular-automata) | ⭐⭐⭐⭐ | rules 90, 30, 110 |
| 17 | [Fold Everything](17-fold-everything) | ⭐⭐⭐⭐ | `fold_left`, `fold_right`, no `rec` allowed |
| 18 | [Big Numbers](18-big-numbers) | ⭐⭐⭐⭐⭐ | arbitrary-precision arithmetic |
| 19 | [The N-Queens Puzzle](19-n-queens) | ⭐⭐⭐⭐⭐ | backtracking |
| 20 | [The Tiny Machine](20-tiny-machine) | ⭐⭐⭐⭐⭐ | writing an interpreter |

Exercises 01–05 are close to the TDs, 06–10 are exam level, 11–20 are real challenges.

## Scoring (optional)

One point per exercise showing `Perfect!`. Bonus point for the first group to finish an exercise,
and for any group that can **explain** its solution to the teacher.

Solutions are not part of this repository: they will be given at the end of the class.

Have fun! 🐫

## Solutions

The solutions are in the `solutions/` folder (`solutions/NN-name.ml`).
