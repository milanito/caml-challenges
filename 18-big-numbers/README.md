# 18 · Big Numbers  ⭐⭐⭐⭐⭐  (challenge)

> *"The Analytical Engine can arrange and combine numerical quantities exactly as if they were letters
> or any other general symbols."*
> — Ada Lovelace, 1843

## The story

In Caml, an `int` is stored on 63 bits: the largest one is `4 611 686 018 427 387 903`, about 4.6 × 10¹⁸.
That sounds enormous, until you try `factorial 21`... and silently get a **wrong, negative number**. 😱
(`20! = 2 432 902 008 176 640 000` is the last factorial that fits.)

But Babbage's Analytical Engine (exercise 01!) was designed to work with numbers of **40 decimal digits**,
and today the cryptography protecting your bank account manipulates numbers with **hundreds of digits**.
How? By representing a number as a **list of digits** and doing arithmetic **exactly like you learned in
primary school**: digit by digit, with a carry.

In this exercise a big number is an `int list` of its decimal digits, **least significant digit first**
(because that is the order in which you add: right to left!):

```
12345   is represented by   [5; 4; 3; 2; 1]
```

Rules of the representation:
- There are **no useless zeros** at the most significant end: `[5; 4; 0]` is not allowed.
- Zero is `[0]`.

You will compute `100!` (a 158-digit number), the number of ways to shuffle a deck of 52 cards, and the first
Fibonacci number that has 1000 digits. 🤯

Read more: [Arbitrary-precision arithmetic](https://en.wikipedia.org/wiki/Arbitrary-precision_arithmetic) ·
[Factorial](https://en.wikipedia.org/wiki/Factorial) ·
[Analytical Engine](https://en.wikipedia.org/wiki/Analytical_Engine)

## Rules

Only `failwith` and `invalid_arg` are allowed, plus the `@` operator. No `List` module.
`examples.ml` defines `to_string : int list -> string` to print a big number (`to_string [5;4;3;2;1]` is `"12345"`).

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `big_of_int : int -> int list` | `big_of_int 12345 = [5; 4; 3; 2; 1]`, `big_of_int 0 = [0]`. Raises `Invalid_argument` if `n < 0` |
| 2 | `add_big : int list -> int list -> int list` | add two big numbers (of **different lengths**!). *Think about the carry.* |
| 3 | `mul_small : int list -> int -> int list` | multiply a big number by an ordinary non-negative `int` `k`. Careful with `k = 0` (the result is `[0]`, not `[0; 0; 0]`) and with carries that are bigger than 9. Raises `Invalid_argument` if `k < 0` |
| 4 | `factorial_big : int -> int list` | `n!` as a big number. Raises `Invalid_argument` if `n < 0` |
| 5 | `fib_big : int -> int list` | the n-th Fibonacci number as a big number (`fib_big 100 = 354224848179261915075`) |
| 6 | `power_big : int -> int -> int list` | `power_big k e` is `k` to the power `e` (`k >= 0` small, `e >= 0`) |
| 7 | `digit_sum : int list -> int` | the sum of the digits |

```ocaml
# to_string (add_big (big_of_int 999) (big_of_int 1));;
- : string = "1000"
# to_string (mul_small (big_of_int 999) 999);;
- : string = "998001"
# to_string (factorial_big 25);;
- : string = "15511210043330985984000000"
# to_string (fib_big 100);;
- : string = "354224848179261915075"
# digit_sum (power_big 2 1000);;
- : int = 1366
```

### 🏆 Questions to answer once it works

- How many digits does `100!` have? What is the sum of its digits?
- Compute `factorial_big 52`: that is the number of different ways to order a deck of cards. Every time you
  properly shuffle a deck, you very likely produce an order that **never existed before in the history of the universe**.
- What is the index of the first Fibonacci number with 1000 digits? (The test file checks `4782`: can you
  find it with a loop on `fib_big` and a `length`?)

## Test your code

```
cd 18-big-numbers
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `add_big`: an inner function `go carry a b`. If both lists are empty, the answer is `[]` (or `[carry]` if
  the carry is not 0). Otherwise take the digits (use `0` for the missing digit of the shorter list), compute
  `s = x + y + carry`; the digit is `s mod 10`, the new carry is `s / 10`.
  Matching on the *pair of lists* `(a, b)` with 4 cases (`[], []`, `x :: _, []`, `[], y :: _`, `x :: _, y :: _`)
  is clean.
- `mul_small`: same idea, with `p = digit * k + carry`. When the digits are over, the carry may still have
  several digits: keep going with `carry mod 10` and `carry / 10`.
- `factorial_big n`: `n! = n × (n-1)!`, so `mul_small (factorial_big (n - 1)) n`.
- `fib_big`: the same as `fib_fast` from exercise 04, but with `add_big`.
- `power_big`: repeated `mul_small`.

</details>

## Next up

**19 · The N-Queens Puzzle**: backtracking, the technique behind Sudoku solvers, chess engines and
every "try everything, undo if it doesn't work" algorithm.
