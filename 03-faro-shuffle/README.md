# 03 · The Faro Shuffle  ⭐☆☆☆☆

> *Shuffle a deck of 52 cards perfectly, 8 times in a row. Look at your cards. They are back in
> their original order.*

## The story

Magicians have known the **perfect riffle shuffle** (the *faro shuffle*) for centuries:
split the deck into two equal halves, then interleave the cards one by one, *exactly*
alternating between the two halves. It is very hard to do with real cards... and very easy with lists.

In 1983 the mathematicians Persi Diaconis, Ron Graham and William Kantor studied this shuffle in depth.
Their discovery: with a deck of 52 cards, if the top card stays on top, **8 perfect shuffles bring
the deck back to the starting order**. Your job: implement the shuffle, then *prove it by running it*.

Read more: [Faro shuffle](https://en.wikipedia.org/wiki/Faro_shuffle) ·
[Shuffling](https://en.wikipedia.org/wiki/Shuffling)

## Rules

Only `failwith` and `invalid_arg` are allowed, plus the `@` operator. No `List` module.
`starter.ml` already gives you `length` (you wrote it in exercise 01).

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `take : int -> 'a list -> 'a list` | the first `n` elements. If `n <= 0` give `[]`, if `n` is too big give the whole list |
| 2 | `drop : int -> 'a list -> 'a list` | everything **except** the first `n` elements (same conventions) |
| 3 | `split_at : int -> 'a list -> 'a list * 'a list` | `(take n lst, drop n lst)` |
| 4 | `cut : int -> 'a list -> 'a list` | cut a deck: the top `n` cards go to the bottom |
| 5 | `riffle : 'a list -> 'a list -> 'a list` | interleave two lists: `a1; b1; a2; b2; ...`. When one list runs out, the rest of the other follows |
| 6 | `faro : 'a list -> 'a list` | perfect shuffle of a deck with an **even** number of cards: riffle (first half) with (second half), **first half first**. Raises `Invalid_argument` for an odd deck |
| 7 | `faro_period : 'a list -> int` | how many perfect shuffles are needed to get the original deck back? (at least 1) |

```ocaml
# take 2 [1; 2; 3; 4; 5];;
- : int list = [1; 2]
# drop 2 [1; 2; 3; 4; 5];;
- : int list = [3; 4; 5]
# cut 2 [1; 2; 3; 4; 5];;
- : int list = [3; 4; 5; 1; 2]
# riffle [1; 3; 5] [2; 4; 6];;
- : int list = [1; 2; 3; 4; 5; 6]
# faro [1; 2; 3; 4; 5; 6];;
- : int list = [1; 4; 2; 5; 3; 6]
# faro_period [1; 2; 3; 4];;
- : int = 2
```

### The moment of truth 🎩

```ocaml
# faro_period (make_deck 52);;
- : int = 8
```

`make_deck n` builds `[1; 2; ...; n]` (it is defined in `examples.ml`).
Also try other deck sizes: 6, 8, 10, 12... Is there a pattern? (Spoiler: it is *not* simple.
Mathematicians still write papers about it.)

## Test your code

```
cd 03-faro-shuffle
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `faro` is just `riffle` applied to the two halves. You already have `take`, `drop` and `length`.
- For `faro_period`, repeat `faro` on the deck, counting, until the deck equals the original one.
  An inner recursive function with the current deck and a counter will do.
- Write `riffle` with a `match` on **both lists at once**: `match a, b with ...`

</details>

## Next up

**04 · Rabbits of Fibonacci**: a problem about breeding rabbits (from 1202!) and your first
encounter with an algorithm that is *too slow*.
