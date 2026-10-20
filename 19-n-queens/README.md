# 19 · The N-Queens Puzzle  ⭐⭐⭐⭐⭐  (challenge)

## The story

> *Place 8 queens on a chessboard so that no queen attacks another one.*

Queens attack along their **row**, their **column** and their two **diagonals**. The puzzle was published in
1848 by the chess composer **Max Bezzel**. The great **Carl Friedrich Gauss** worked on it and found only 72 of
the **92** solutions; the complete list came in 1850. 😅

In 1972, **Edsger Dijkstra** used the 8-queens problem to explain **backtracking**: build the solution
*step by step*, placing one queen per row; as soon as a placement is impossible, **go back** and try
something else. This technique is the heart of Sudoku solvers, chess engines, route planners, compilers
(regular expressions!) and countless puzzle solvers.

Think of the board **row by row**. A partial solution is the list of the **columns** where the queens of the
previous rows are:

```
  . Q . .        row 1: column 2
  . . . Q        row 2: column 4
  Q . . .        row 3: column 1
  . . Q .        row 4: column 3     ->   the solution [3; 1; 4; 2]   (most recent row first)
```

Since we place one queen per row, two queens can never be on the same row. You only have to check
the **column** and the **diagonals** of the new queen against the queens already placed.

Read more: [Eight queens puzzle](https://en.wikipedia.org/wiki/Eight_queens_puzzle) ·
[Backtracking](https://en.wikipedia.org/wiki/Backtracking) ·
[Edsger Dijkstra](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra)

## Rules

Only `failwith`, `invalid_arg`, `abs` (absolute value) and the `@` operator are allowed. No `List` module.
Columns are numbered from `1` to `n`.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `safe : int -> int list -> bool` | `safe q placed`: can a queen be put in column `q` of the **next row**, given that `placed` is the list of the columns of the queens of the previous rows, **the nearest row first**? It must be in a different column from all of them, and on none of their diagonals. (The queen of the row at distance `d` attacks columns `c - d` and `c + d`.) |
| 2 | `queens : int -> int list list` | **all** the solutions of the `n`-queens problem: each solution is a list of `n` columns (the order of the solutions in the result does not matter). Raises `Invalid_argument` if `n < 1` |
| 3 | `count_queens : int -> int` | how many solutions? |

```ocaml
# safe 3 [1];;           (* a queen in column 1 on the row just above *)
- : bool = true
# safe 2 [1];;           (* diagonal! *)
- : bool = false
# safe 3 [5; 1];;        (* the queen two rows above is in column 1: |1 - 3| = 2 = the distance *)
- : bool = false
# queens 4;;
- : int list list = [[3; 1; 4; 2]; [2; 4; 1; 3]]
# count_queens 8;;
- : int = 92
```

The numbers of solutions for `n = 1, 2, 3, ...` are `1, 0, 0, 2, 10, 4, 40, 92, 352, 724, ...`
(look at the pattern: it is not monotonic, and nobody knows a formula!).

### 🖼️ The board

At the end of `examples.ml`, the first solution found by **your** `queens 8` is drawn as a board.

## Test your code

```
cd 19-n-queens
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `safe q placed`: walk through `placed` with a **distance** `d` starting at 1 and increasing at each row.
  The queen in column `c` is a problem if `c = q` or `abs (c - q) = d`.
- `queens n`: build the solutions **row by row**. `place k` gives all the ways to place the first `k`
  queens (a list of partial solutions). `place 0 = [[]]` (one way to place no queen: the empty board).
  To compute `place k` from `place (k - 1)`: **extend** every partial solution with every column `q`
  from `1` to `n` such that `safe q partial` is true.
- Test with `queens 4` first (2 solutions), then 5, then 6...
- Don't be afraid: the whole program is about 15 lines.

</details>

## Next up

**20 · The Tiny Machine**: the final boss. You are going to write an **interpreter** for a programming
language that has only 8 instructions. And it is Turing-complete. 🧠
