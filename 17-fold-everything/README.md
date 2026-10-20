# 17 · Fold Everything  ⭐⭐⭐⭐☆  (challenge)

## The story

Look back at your list functions: `sum`, `length`, `map`, `filter`, `flatten`, `for_all`...
They all look the same, don't they?

```ocaml
let rec sum = function [] -> 0 | e :: l -> e + sum l       (* "combine e with the result on the rest" *)
let rec length = function [] -> 0 | _ :: l -> 1 + length l
```

A value for `[]`, and a way of **combining** the first element with the result for the rest.
That pattern has a name: a **fold** (also called *reduce*). It is such a fundamental idea that, in the
2000s, Google built its famous **MapReduce** system on the idea that `map` and `reduce` are
enough to process the whole web, in parallel, on thousands of machines. 🌐

There are two folds:

```ocaml
fold_right f [a; b; c] z  =  f a (f b (f c z))        (* the recursion you know. NOT tail-recursive *)
fold_left  f z [a; b; c]  =  f (f (f z a) b) c        (* an accumulator going left to right. Tail-recursive *)
```

Both are given to you in `starter.ml` (you saw them in the TD: `fold_right` is the `process_list` of the bonus
exercise).

**Your challenge:** rebuild your favourite list functions **with no recursion of your own**.
Only calls to `fold_left` or `fold_right`, plus little anonymous functions.

Read more: [Fold (higher-order function)](https://en.wikipedia.org/wiki/Fold_%28higher-order_function%29) ·
[MapReduce](https://en.wikipedia.org/wiki/MapReduce)

## Rules

- ⚠️ **The word `rec` is forbidden in your answers.** (The two given folds are the only recursive functions
  allowed.) Your teacher can `grep` for it. 😉
- You can use pattern matching on *options and pairs* (e.g. `fun e (yes, no) -> ...`) and `if`.
  In a couple of places you may use `match` to look at the **first element** of a list, but not to loop.
- Only `failwith` and `invalid_arg` are allowed as predefined functions. No `List` module.
- You may use functions you already defined above in the same file (for example `append` inside `flatten`).

## Your tasks

| # | Function | Hint about which fold |
|---|----------|--------------|
| 1 | `length : 'a list -> int` | `fold_left`: count |
| 2 | `sum : int list -> int` | `fold_left` |
| 3 | `rev : 'a list -> 'a list` | `fold_left`: **the accumulator is a list** |
| 4 | `map : ('a -> 'b) -> 'a list -> 'b list` | `fold_right` |
| 5 | `filter : ('a -> bool) -> 'a list -> 'a list` | `fold_right` |
| 6 | `append : 'a list -> 'a list -> 'a list` | `fold_right` over the **first** list, with the second one as starting value |
| 7 | `flatten : 'a list list -> 'a list` | `fold_right` and `append` |
| 8 | `max_elt : 'a list -> 'a` | the largest element. Raises `Failure` on `[]` |
| 9 | `partition : ('a -> bool) -> 'a list -> 'a list * 'a list` | **one single fold**. The accumulator is a **pair** of lists. Order must be preserved |
| 10 | `for_all : ('a -> bool) -> 'a list -> bool` | `for_all p [] = true` |
| 11 | `unzip : ('a * 'b) list -> 'a list * 'b list` | `unzip [(1,'a'); (2,'b')] = ([1; 2], ['a'; 'b'])` |
| 12 | 🧠 `my_fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a` | **the boss**: `fold_left`, implemented with `fold_right` |

```ocaml
# map (fun x -> x * 2) [1; 2; 3];;
- : int list = [2; 4; 6]
# partition (fun x -> x mod 2 = 0) [1; 2; 3; 4; 5];;
- : int list * int list = ([2; 4], [1; 3; 5])
# my_fold_left (-) 10 [1; 2; 3];;
- : int = 4            (* ((10 - 1) - 2) - 3 *)
```

### 🧠 About the boss (task 12)

`fold_left` goes from left to right, `fold_right` from right to left. How could one simulate the other?
**By making the accumulator a function.** Instead of computing a *value*, let `fold_right` build a
*function* that takes the accumulator as a parameter and does all the work.
When you understand this, you have understood something that many professional programmers never do.

<details>
<summary>💡 Hint for the boss (open only if you really tried!)</summary>

Think about what `fold_right` must compute for `[b1; b2; b3]`: a function `g` such that `g a` is
`f (f (f a b1) b2) b3`. For the last element `b3`: `fun a -> f a b3`. For `b2` followed by the function `k` that
handles the rest: `fun a -> k (f a b2)`. The starting value (empty list) is the identity function `fun a -> a`.

</details>

## Test your code

```
cd 17-fold-everything
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

The **first parameter of the function given to the fold is the element, then the accumulator**
for `fold_right`: `fold_right (fun e acc -> ...) lst start`.
It is the opposite for `fold_left`: `fold_left (fun acc e -> ...) start lst`.

For `length`: `fold_left (fun n _ -> n + 1) 0 lst`. Can you do all the others in the same spirit?

For `max_elt`, start the fold with the first element: `match lst with [] -> failwith "..." | h :: t -> fold_left ... h t`.

</details>

## Next up

**18 · Big Numbers**: the biggest `int` in Caml is about 4.6 × 10¹⁸. What if you want 100 factorial? Time to
teach the machine to count on its fingers, like Babbage's engine.
