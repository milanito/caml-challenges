# 20 · The Tiny Machine  ⭐⭐⭐⭐⭐  (final boss)

## The story

In 1993, a Swiss student named **Urban Müller** wanted to build the **smallest possible compiler** for his
Amiga. He designed a language with only **8 instructions**, and his compiler weighed **240 bytes**.
The language is called **Brainf\*ck** (yes, really, the name is a joke), and it is an **esoteric programming language**:
a language designed to be a puzzle, not to be pleasant.

Despite its absurd simplicity, it is **Turing-complete**: anything that any computer can compute, a Brainf\*ck
program can compute too (very slowly, and very painfully). That is the same idea as the
**Turing machine** (1936), the theoretical model of all computers: a **tape** of cells, a **head** that reads
and writes, and a few rules.

Today **you write the machine**. An *interpreter* is just a function that reads a program and does what it says.
It is exactly what `python`, `ocaml` or your browser's JavaScript engine do, only a bit bigger. 😉

Read more: [Brainf\*ck](https://en.wikipedia.org/wiki/Brainfuck) ·
[Turing machine](https://en.wikipedia.org/wiki/Turing_machine) ·
[Esoteric programming language](https://en.wikipedia.org/wiki/Esoteric_programming_language) ·
[Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing)

## The machine

The machine has a **tape** of cells, infinite in both directions. Each cell contains a number from `0` to `255`
and all of them start at `0`. A **head** points at one cell (the *current* cell). A program is a list of characters:

| Char | Meaning |
|------|---------|
| `>` | move the head one cell to the **right** |
| `<` | move the head one cell to the **left** |
| `+` | add 1 to the current cell (**255 + 1 gives 0**) |
| `-` | subtract 1 from the current cell (**0 - 1 gives 255**) |
| `.` | **output** the current cell, as the character with that code |
| `[` | if the current cell is `0`, **jump forward** to just after the matching `]`. Otherwise go on |
| `]` | if the current cell is **not** `0`, **jump back** to the matching `[`. Otherwise go on |
| anything else | **ignored** (so you can write comments!) — including the `,` of the original language |

Brackets can be nested: `[ [ ] [ ] ]`. If the program uses a bracket that has no matching one *when it needs to jump*,
`run` must raise `Failure`.

Example, `++[>+++<-]>.`:
the first cell gets 2; then the loop `[>+++<-]` adds 3 to the second cell and subtracts 1 from the first one,
until the first is 0. So the second cell is `2 × 3 = 6`; the output is the character of code 6.

## Your tasks

| # | Name | What it does |
|---|------|--------------|
| 1 | `run : char list -> char list` | runs the program, returns the list of the characters it has output |
| 2 | `my_hi_program : string` | **write a Brainf\*ck program** (a string!) that outputs `Hi!` |
| 3 | `my_alphabet_program : string` | write a program that outputs `ABCDEFGHIJKLMNOPQRSTUVWXYZ` |

To get `H` (code 72) you need to put 72 in a cell; typing 72 `+` is allowed but **loops** are shorter and
way cooler: `++++++++[>+++++++++<-]` puts `8 × 9 = 72` in the next cell. For the alphabet, a loop that outputs a
cell, adds 1 to it and counts down in another cell will do.

`examples.ml` also contains a famous program, **Hello World!**, that your interpreter must run correctly. 🌍

```ocaml
# run ['+'; '+'; '+'; '.'];;
- : char list = ['\003']
# run (explode "++++++++[>++++++++<-]>+.");;       (* 8 x 8 + 1 = 65 *)
- : char list = ['A']
```

## Rules

Only `failwith` and `invalid_arg`, `@`, `Char.chr` and `Char.code` are allowed. No `List` module.
`examples.ml` defines `explode : string -> char list`.

## Test your code

```
cd 20-tiny-machine
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

**How to represent the tape?** A list is not infinite on both sides, but you can use a **zipper**:
a triple `(left, current, right)` where `left` is the list of the cells on the left of the head (**nearest first**)
and `right` the list of the cells on the right.
- Moving right: the current cell is pushed on `left`, and the new current cell is the head of `right`
  (or `0` if `right` is empty: the tape is infinite!).
- Moving left: the symmetric.

**How to represent the program?** The same trick: `before` (the instructions already seen, nearest first)
and `after` (the instruction to execute is its first element).
- `[` with a zero cell: walk forward in `after` while counting the depth of nested brackets.
- `]` with a non-zero cell: walk backward in `before`, same idea.

Write the main loop `exec before after tape output`. Accumulate the output reversed and reverse it at the end.
Start with a program with no brackets, then add them. Test each instruction in `examples.ml` as you go!

Wrap-around: `(cur + 1) mod 256` and `(cur + 255) mod 256`.

</details>

## 🏁 Congratulations

If you reached this point, you have written in Caml the same kind of program that runs every programming language
in the world. Take a screenshot of your 20/20 and be proud. 🎉
