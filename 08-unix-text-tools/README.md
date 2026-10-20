# 08 · Unix Text Tools  ⭐⭐⭐☆☆

> *"Write programs that do one thing and do it well. Write programs to work together.
> Write programs to handle text streams, because that is a universal interface."*
> — the Unix philosophy, summarised by Doug McIlroy

## The story

In the early 1970s, at Bell Labs, **Ken Thompson** and **Dennis Ritchie** created Unix. Its power came
from dozens of tiny tools (`wc`, `uniq`, `sort`, `cut`, `grep`...) that you chain with the **pipe** `|`,
an idea pushed by **Doug McIlroy**. Want the list of distinct words in a text file? It is one line of
shell:

```
cat book.txt | tr ' ' '\n' | sort | uniq
```

Today you rebuild three of these tools in Caml, working on **`char list`** values (a text is a list
of characters). Linux, macOS, Android and most of the internet's servers still run on this heritage.

Read more: [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy) ·
[wc](https://en.wikipedia.org/wiki/Wc_%28Unix%29) ·
[uniq](https://en.wikipedia.org/wiki/Uniq) ·
[Pipeline](https://en.wikipedia.org/wiki/Pipeline_%28Unix%29)

## Rules

Only `failwith` and `invalid_arg` are allowed. No `List` module.
`explode : string -> char list` and `implode : char list -> string` are defined in `examples.ml`
(handy to play in utop: `explode "hello"`).

A **whitespace** character is a space `' '`, a newline `'\n'` or a tab `'\t'`.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `words : char list -> char list list` | split a text into **words** (maximal sequences of non-whitespace characters). Never returns an empty word |
| 2 | `uniq : 'a list -> 'a list` | remove **consecutive** duplicates (exactly like Unix `uniq`) |
| 3 | `wc : char list -> int * int * int` | `(lines, words, characters)`. *lines* = number of `'\n'` characters, *characters* = length of the text |
| 4 | `longest_word : char list -> char list` | the longest word of the text (the first one if there is a tie). Raises `Failure` if the text has no words |

```ocaml
# List.map implode (words (explode "  the quick   brown\tfox \n"));;
- : string list = ["the"; "quick"; "brown"; "fox"]
# uniq [1; 1; 2; 2; 2; 1; 3; 3];;
- : int list = [1; 2; 1; 3]
# wc (explode "hello world\nthis is a test\n");;
- : int * int * int = (2, 6, 27)
# implode (longest_word (explode "the quick brown fox"));;
- : string = "quick"
```

Note that `uniq` only removes **consecutive** duplicates: `[1; 2; 1]` is unchanged. That is why on
Unix you almost always run `sort` before `uniq`. The tests check exactly that pipeline:
`uniq (sorted letters of "mississippi")`.

## Test your code

```
cd 08-unix-text-tools
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `words`: skip whitespace; when you meet a non-whitespace character, **collect characters until the next
  whitespace**. A small helper returning a *pair* `(the_word, the_rest_of_the_text)` is very handy.
  Then the answer is `the_word :: words the_rest`.
- `uniq`: look at the **first two** elements: `a :: (b :: _ as rest)`.
- `wc`: three very small counting functions, or one function returning a triple. Reuse `words`!
- `longest_word`: you may write your own `length` helper.

</details>

## Next up

**09 · Pascal's Triangle**: a 17th-century triangle of numbers that secretly draws a fractal.
Yes, really.
