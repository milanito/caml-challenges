# 16 · Cellular Automata  ⭐⭐⭐⭐☆  (challenge)

## The story

Take a row of cells. Each cell is **alive** (`#`) or **dead** (`.`). At each tick, every cell looks at itself
and its two neighbours and decides, by a fixed rule, whether it is alive at the next tick.
That's it. And yet...

In 1983, **Stephen Wolfram** studied the 256 possible rules of this kind (the *elementary cellular automata*)
and found that some of them produce stunning complexity out of a **single living cell**:

- **Rule 90** draws the fractal **Sierpinski triangle** (the same one hidden in Pascal's triangle, exercise 09!).
- **Rule 30** looks completely **random**. It was used as the random number generator of a famous
  mathematical software, and it patterns the shell of the cone snail *Conus textile*. 🐚
- **Rule 110** is **Turing-complete**: this row of dumb cells can compute *anything* a computer can compute
  (proved by Matthew Cook, published in 2004).

A whole universe in three-cell neighbourhoods. 🌌

Read more: [Elementary cellular automaton](https://en.wikipedia.org/wiki/Elementary_cellular_automaton) ·
[Rule 30](https://en.wikipedia.org/wiki/Rule_30) · [Rule 110](https://en.wikipedia.org/wiki/Rule_110) ·
[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) (the 2D cousin)

## How a rule number works

A cell's neighbourhood (left, itself, right) has 8 possible configurations. Read it as a binary number
(`#` = 1, `.` = 0): `###` is 7, `##.` is 6, ..., `...` is 0. A **rule** says, for each of the 8 configurations,
what the cell becomes. Wolfram's trick: write those 8 answers as the **bits of a number** between 0 and 255.
The answer for configuration `i` is **bit `i` of the rule number** (bit 0 is the rightmost/least significant).

Rule 90 is `01011010` in binary: bits 1, 3, 4 and 6 are set.

| neighbourhood | `###` | `##.` | `#.#` | `#..` | `.##` | `.#.` | `..#` | `...` |
|---|---|---|---|---|---|---|---|---|
| index `i` | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| rule 90 gives | 0 | 1 | 0 | 1 | 1 | 0 | 1 | 0 |

In a finite row, the cells **outside** the row (to the left of the first one, to the right of the last one)
are considered **dead**.

## Rules (of the exercise)

Only `failwith` and `invalid_arg` are allowed, plus the `@` operator. No `List` module.
Cells are `bool` values (`true` = alive). `starter.ml` gives you `power2 : int -> int` (`power2 3 = 8`):
the `i`-th bit of `r` is `(r / power2 i) mod 2`.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `rule_bit : int -> int -> bool` | `rule_bit rule i`: is bit `i` of `rule` set? Raises `Invalid_argument` unless `0 <= rule <= 255` and `0 <= i <= 7` |
| 2 | `single_cell : int -> bool list` | a row of `width` dead cells with **one** living cell at position `width / 2` (positions start at 0). Raises `Invalid_argument` if `width < 1` |
| 3 | `step : int -> bool list -> bool list` | one tick: `step rule cells` computes the next row (same length) |
| 4 | `run : int -> int -> bool list -> bool list list` | `run rule n cells` is the list of the `n + 1` successive rows: the initial one, then `n` ticks. Raises `Invalid_argument` if `n < 0` |
| 5 | `populations : int -> int -> int -> int list` | `populations rule width n`: starting from `single_cell width`, the **number of living cells** in each of the `n + 1` rows |

```ocaml
# show (single_cell 7);;
- : string = "...#..."
# show (step 90 (single_cell 7));;
- : string = "..#.#.."
# List.map show (run 90 3 (single_cell 7));;
- : string list = ["...#..."; "..#.#.."; ".#...#."; "#.#.#.#"]
# populations 90 31 7;;
- : int list = [1; 2; 2; 4; 2; 4; 4; 8]
```

(`show : bool list -> string` is defined in `examples.ml`.)

Did you notice the populations of rule 90? `1, 2, 2, 4, 2, 4, 4, 8`: always a **power of 2**. That is
Sierpinski's triangle talking.

### 🎆 The show

When the tests are done, `examples.ml` automatically draws rules 90, 30 and 110 with **your** `run`. Pick any other
rule from 0 to 255 (try 18, 22, 54, 60, 150, 182, 193, 225...) with `animate 22 31 15;;` and enjoy.

## Test your code

```
cd 16-cellular-automata
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

For `step`, walk along the row while **remembering the previous cell** (the left neighbour; it is `false` at
the beginning). At each cell, look at the next cell too (the right neighbour; it is `false` at the very end).
An inner function with a parameter `left` and a `match` that peeks at the rest of the list does it:

```ocaml
let step rule cells =
  let rec go left = function
    | [] -> []
    | c :: rest ->
      let right = (match rest with [] -> false | r :: _ -> r) in
      ... :: go c rest
  in
  go false cells
```

You need to convert three booleans into the number `4 * l + 2 * c + r`: write a tiny `bit : bool -> int`.

</details>

## Next up

**17 · Fold Everything**: one function to rule them all. Many of your favourite list functions are secretly
the same function in disguise.
