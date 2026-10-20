# 10 · Merge Sort  ⭐⭐⭐⭐☆

## The story

In 1945, **John von Neumann** was working on the **EDVAC**, one of the first computers that stored
its *program* in memory next to its data (the architecture of virtually every computer today).
He needed to show that such a machine could do something non-numerical and useful, so he wrote a
program that **sorts**. It was the first **merge sort**, and it is still one of the best sorting algorithms.

The idea fits in three lines:

1. If the list has 0 or 1 element, it is already sorted.
2. Otherwise **cut it in two**, sort each half (recursively!)...
3. ...and **merge** the two sorted halves: repeatedly take the smaller of the two first elements.

The magic is the cost. Insertion sort (the one from your exam) needs about `n²` steps.
Merge sort needs about `n × log n`. For one million elements, that is the difference between
*"a few seconds"* and *"a few days"*. 🚀

Read more: [Merge sort](https://en.wikipedia.org/wiki/Merge_sort) ·
[EDVAC](https://en.wikipedia.org/wiki/EDVAC) ·
[John von Neumann](https://en.wikipedia.org/wiki/John_von_Neumann)

## Rules

Only `failwith` and `invalid_arg` are allowed. No `List` module. Your functions must be **polymorphic**.
Like in your exam, the ordering is a function: `order x y` is `true` when `x` may come
**before** `y`.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `merge : ('a -> 'a -> bool) -> 'a list -> 'a list -> 'a list` | merge two lists, **each already sorted** according to `order`, into one sorted list |
| 2 | `halve : 'a list -> 'a list * 'a list` | deal the elements alternately into two lists, like cards: `halve [1;2;3;4;5] = ([1;3;5], [2;4])`. (The two lists differ in length by at most 1.) |
| 3 | `merge_sort : ('a -> 'a -> bool) -> 'a list -> 'a list` | sort a list |

```ocaml
# merge (<=) [1; 4; 9] [2; 3; 10];;
- : int list = [1; 2; 3; 4; 9; 10]
# merge (>=) [9; 4; 1] [10; 3; 2];;
- : int list = [10; 9; 4; 3; 2; 1]
# halve [1; 2; 3; 4; 5];;
- : int list * int list = ([1; 3; 5], [2; 4])
# merge_sort (<=) [5; 3; 8; 1; 4];;
- : int list = [1; 3; 4; 5; 8]
# merge_sort (fun a b -> String.length a <= String.length b) ["ccc"; "a"; "bb"];;
- : string list = ["a"; "bb"; "ccc"]
```

(`(<=)` is the function `fun x y -> x <= y`: operators are functions in disguise.)

### ⏱️ The big test

`examples.ml` sorts a list of **50 000 pseudo-random numbers** and compares with the official
`List.sort`. If your merge sort is correct, this takes a fraction of a second.
*Optional experiment:* write the insertion sort you did in the exam and try it on the same list.
Time to make some tea.

## Test your code

```
cd 10-merge-sort
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `merge`: match **both** lists at once. If one is empty, the answer is the other.
  Otherwise compare the two heads with `order`.
- `halve`: recursive call on the list *without its first two elements*, then put the first element in
  one list and the second in the other. Don't forget the case of a list with exactly one element.
- `merge_sort`: be careful with the base cases (`[]` and `[_]`). With a list of 2 or more elements both
  halves are strictly smaller, so the recursion terminates.

</details>

## Next up

You finished the "exam level" part. 🎓 From now on the exercises are **challenges**: longer, trickier,
more fun. First stop: a conjecture that nobody in the world has been able to prove.
