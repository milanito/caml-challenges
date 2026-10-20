# 01 · Ada's Notes  ⭐☆☆☆☆

> *"The Analytical Engine weaves algebraical patterns just as the Jacquard loom weaves flowers and leaves."*
> — Ada Lovelace, 1843

## The story

In 1843, **Ada Lovelace** translated a short article about Charles Babbage's *Analytical Engine*
(a mechanical computer that was never finished). She then added her own "Notes", which ended up
**three times longer than the article**. Note G contains a step-by-step method for computing
Bernoulli numbers on the machine, which is why many people call it **the first computer program**.

But Ada's real insight was deeper: she realised a machine could manipulate *symbols*, not just numbers.
That is exactly what you do all day in Caml: lists of anything, processed by tiny functions.

These five warm-up functions are the bricks of everything else in this repository.
Build them well. You will reuse them. 🧱

Read more: [Ada Lovelace](https://en.wikipedia.org/wiki/Ada_Lovelace) ·
[Analytical Engine](https://en.wikipedia.org/wiki/Analytical_Engine)

## Rules

Only `failwith` and `invalid_arg` are allowed as predefined functions (like in the exams).
No `List` module. Write your own recursion!

## Your tasks

Open `starter.ml`, replace each `failwith "TODO"` with real code.

| # | Function | What it does |
|---|----------|--------------|
| 1 | `sum : int list -> int` | sum of all the elements (`0` for the empty list) |
| 2 | `length : 'a list -> int` | number of elements |
| 3 | `last : 'a list -> 'a` | last element. Raises `Failure` on the empty list |
| 4 | `average : int list -> int` | integer average (`sum / length`, rounded down). Raises `Invalid_argument` on the empty list. **Reuse `sum` and `length`!** |
| 5 | `range : int -> int -> int list` | `range a b` is `[a; a+1; ...; b]`, and `[]` if `a > b` |

```ocaml
# sum [1; 2; 3; 4];;
- : int = 10
# length ["a"; "b"; "c"];;
- : int = 3
# last [4; 8; 15; 16; 23; 42];;
- : int = 42
# average [10; 20; 30];;
- : int = 20
# range 1 5;;
- : int list = [1; 2; 3; 4; 5]
# sum (range 1 100);;
- : int = 5050
```

That last line is the famous sum the young **Gauss** computed in his head at school. Your computer
does it a bit faster than a Babbage engine would have. 😉

## Test your code

```
cd 01-adas-notes
utop
# #use "starter.ml";;     (* loads YOUR functions *)
# #use "examples.ml";;    (* runs the tests *)
```

Edit `starter.ml`, save, and `#use` both files again. Repeat until every line says `[ OK ]`.

<details>
<summary>💡 Stuck? Click for a hint</summary>

Every list function here has the same two cases: the empty list `[]`, and `e :: rest`.
Ask yourself: *"if I already knew the answer for `rest`, what would the answer for `e :: rest` be?"*

For `last`, you need a third case: the list with exactly one element, `[e]`.

</details>

## Next up

**02 · Hopper's Bug**: a real moth, a real logbook, and your first hunt for a needle in a haystack.
