# 02 · Hopper's Bug  ⭐☆☆☆☆

> *"First actual case of bug being found."*
> — a caption in the Harvard Mark II logbook, 9 September 1947

## The story

In September 1947 the operators of the **Harvard Mark II**, an enormous electromechanical computer,
found a malfunction in one of its relays. The culprit was a **moth** trapped between the contacts.
They carefully taped it into the logbook and wrote the caption above.
The logbook is now in the Smithsonian, and the story is associated with the pioneer
**Grace Hopper** (who also invented one of the first compilers).

Fun fact: engineers were already calling glitches "bugs" long before that. Thomas Edison used the word
in 1878. But the moth is *so* good a story that it stuck. 🦋

Today you are the debugger. You get a **logbook** (a list) and you must find, count and squash bugs.

Read more: [Grace Hopper](https://en.wikipedia.org/wiki/Grace_Hopper) ·
[Software bug](https://en.wikipedia.org/wiki/Software_bug)

## Rules

Only `failwith` and `invalid_arg` are allowed as predefined functions. No `List` module.
Your functions must work on lists of **any** type (strings, ints, chars...), so don't be too specific.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `mem : 'a -> 'a list -> bool` | is the element in the list? |
| 2 | `index_of : 'a -> 'a list -> int` | position of the **first** occurrence. **The first position is 1.** Raises `Failure` if absent |
| 3 | `positions : 'a -> 'a list -> int list` | positions (starting at 1) of **all** the occurrences, in increasing order |
| 4 | `remove_first : 'a -> 'a list -> 'a list` | remove the first occurrence (if any) |
| 5 | `squash : 'a -> 'a list -> 'a list` | remove **every** occurrence |

```ocaml
# let log_book = ["start"; "test"; "bug"; "test"; "bug"; "done"];;

# mem "bug" log_book;;
- : bool = true
# index_of "bug" log_book;;
- : int = 3
# positions "bug" log_book;;
- : int list = [3; 5]
# remove_first "bug" log_book;;
- : string list = ["start"; "test"; "test"; "bug"; "done"]
# squash "bug" log_book;;
- : string list = ["start"; "test"; "test"; "done"]
# index_of "moth" log_book;;
Exception: Failure "index_of: not found".
```

## Test your code

```
cd 02-hoppers-bug
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

For `index_of` and `positions` you need to **remember the current position** while walking along the list.
A common trick: write an inner function with an extra parameter `i` that counts, and call it with `i = 1`.

```ocaml
let index_of x lst =
  let rec go i = function
    | [] -> ...
    | e :: rest -> ...
  in
  go 1 lst
```

</details>

## Next up

**03 · The Faro Shuffle**: cut, riffle and discover a card trick that magicians (and mathematicians) adore.
