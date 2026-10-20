# 12 · Roman Numerals  ⭐⭐⭐⭐☆  (challenge)

> *SPQR: "Senatus Populusque Romanus". And in 2026 it is written MMXXVI.*

## The story

The Romans had no zero, no place-value system, and yet they ran an empire with
`I V X L C D M`. Their numbers are still carved on clocks, book chapters, Super Bowls and the
credits of old movies. 🎬

Rules (the *modern* standard form):

| Symbol | I | V | X | L | C | D | M |
|--------|---|---|---|---|---|---|---|
| Value | 1 | 5 | 10 | 50 | 100 | 500 | 1000 |

- Symbols are written from largest to smallest and **added**: `XVI = 10 + 5 + 1 = 16`.
- Except for six **subtractive** pairs: `IV = 4`, `IX = 9`, `XL = 40`, `XC = 90`, `CD = 400`, `CM = 900`.
- So `1994 = M + CM + XC + IV = MCMXCIV`.
- Numerals only go from `1` to `3999`.

Translating in both directions is an excellent exercise in **lists of couples** (like the `assoc`
function from your exams): a *table* of `(value, symbol)` pairs does most of the work.

Read more: [Roman numerals](https://en.wikipedia.org/wiki/Roman_numerals)

## Rules

Numerals are **`char list`** values (`['X'; 'I'; 'V']`). `examples.ml` provides `explode` and
`implode` to convert from/to strings. Only `failwith` and `invalid_arg` are allowed. No `List` module.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `roman_of_int : int -> char list` | the numeral of a number between 1 and 3999. Raises `Invalid_argument` otherwise |
| 2 | `int_of_roman : char list -> int` | the value of a numeral. Raises `Failure` if a character is not one of `IVXLCDM`. (Valid numerals only: you don't have to detect malformed ones such as `IIX`.) |
| 3 | `add_roman : char list -> char list -> char list` | add two numerals and give the result as a numeral: `XIV + XXVIII = XLII`. Raises `Invalid_argument` if the result is above 3999 |
| 4 | `longest_roman : unit -> int` | among all the numbers from 1 to 3999, which one has the **longest** numeral? |

```ocaml
# implode (roman_of_int 1994);;
- : string = "MCMXCIV"
# int_of_roman (explode "MMXXVI");;
- : int = 2026
# implode (add_roman (explode "XIV") (explode "XXVIII"));;
- : string = "XLII"
```

For task 4 the signature is `unit -> int`: call it as `longest_roman ()`. The answer is a surprising
number, and you must **compute** it (no cheating by guessing). 😄

## Test your code

```
cd 12-roman-numerals
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

The test file also checks `int_of_roman (roman_of_int n) = n` for **every** `n` from 1 to 3999.

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `roman_of_int`: keep the table
  `[(1000, 'M'); (900, ...); ...]`  but a symbol like `CM` has **two** letters, so store a
  `char list` in each pair: `(900, ['C'; 'M'])`. Then, going down the table: while the number is at least
  the current value, output the symbol(s) and subtract; otherwise go on to the next row of the table.
- `int_of_roman`: read left to right. A symbol is **subtracted** when it is smaller than the symbol after
  it, **added** otherwise. A helper `value : char -> int` makes it readable.
- `add_roman` is two conversions and one `+`. The art of reusing your own functions.

</details>

## Next up

**13 · Sieve & Goldbach**: find all the primes with a 2200-year-old algorithm, then test a
conjecture from 1742.
