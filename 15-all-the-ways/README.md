# 15 · All the Ways  ⭐⭐⭐⭐☆  (challenge)

## The story

How many ways are there to...

- **choose** some toppings for a pizza? (*subsets*: `2ⁿ` of them)
- **line up** 8 people for a photo? (*permutations*: `n!`, i.e. 40 320 ways)
- **pick** 3 people among 10 for a team? (*combinations*: 120 ways)

Combinatorics is the art of counting, but today you will go further: **list every single possibility**.
It is the foundation of *exhaustive search* ("try everything"), and it leads straight to one of the most
famous problems in computer science: the **Travelling Salesman Problem**. 🧳

A salesman must visit `n` cities exactly once each and come back home, as cheaply as possible.
The obvious method: list all the *permutations* of the cities and take the cheapest tour. It works...
but with 20 cities there are about 10¹⁷ tours. No computer can try them all, and nobody knows a fundamentally
faster method (the P versus NP question, one million dollars from the Clay Institute, is related).

Read more: [Permutation](https://en.wikipedia.org/wiki/Permutation) ·
[Combination](https://en.wikipedia.org/wiki/Combination) ·
[Travelling salesman problem](https://en.wikipedia.org/wiki/Travelling_salesman_problem) ·
[Anagram](https://en.wikipedia.org/wiki/Anagram)

## Rules

Only `failwith` and `invalid_arg` are allowed, plus the `@` operator. No `List` module (write your own `map`!).
In **tasks 1 to 3, the order of the solutions inside the result does not matter** (the tests sort
the results before comparing). You may assume the input elements are **all different**.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `subsets : 'a list -> 'a list list` | all the subsets of a list (including `[]` and the whole list). **Inside each subset, keep the original order** of the elements |
| 2 | `permutations : 'a list -> 'a list list` | all the orderings of a list |
| 3 | `combinations : int -> 'a list -> 'a list list` | `combinations k lst`: all the subsets of **exactly** `k` elements (original order kept inside each). Raises `Invalid_argument` if `k < 0` |
| 4 | `shortest_tour : ('a -> 'a -> int) -> 'a -> 'a list -> int` | the Travelling Salesman: `shortest_tour dist start others` is the **length of the shortest round trip** that starts at `start`, visits every city of `others` exactly once, and comes back to `start`. `dist a b` gives the distance between two cities. With no other city, the answer is `0` |

```ocaml
# subsets [1; 2; 3];;
- : int list list = [[]; [3]; [2]; [2; 3]; [1]; [1; 3]; [1; 2]; [1; 2; 3]]    (* any order is fine *)
# permutations [1; 2; 3];;
- : int list list = [[1; 2; 3]; [2; 1; 3]; [2; 3; 1]; [1; 3; 2]; [3; 1; 2]; [3; 2; 1]]   (* any order *)
# combinations 2 [1; 2; 3; 4];;
- : int list list = [[1; 2]; [1; 3]; [1; 4]; [2; 3]; [2; 4]; [3; 4]]
```

### 🔤 Anagrams

`permutations` of the letters of `LISTEN` contains `SILENT`. The tests check it, among its 720 anagrams. 😮

### 🧳 The salesman's map

`examples.ml` defines 5 cities `A B C D E` on a grid, and a distance function `dist` (the "taxi" distance:
`|x1-x2| + |y1-y2|`). Can you find, before running anything, the shortest tour starting from `A`?
(The test knows the answer. Is your guess right?)

## Test your code

```
cd 15-all-the-ways
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

- `subsets`: take the first element `e`. Every subset either **doesn't contain it** (those are exactly
  `subsets rest`) or **contains it** (those are `e ::` each subset of `rest`). Append both families.
- `permutations`: take the first element `e` and all the permutations of the rest. In each one of them, `e`
  can be inserted in every possible position. A function `insert_everywhere` is your friend.
- `combinations k lst`: either the first element is chosen (then you need `k-1` more among the rest) or it
  is not (you need `k` among the rest). Don't forget `k = 0` (one solution: `[]`) and the empty list.
- `shortest_tour`: for every permutation of `others`, compute the length of the round trip, keep the smallest.

</details>

## Next up

**16 · Cellular Automata**: a row of cells, three-cell neighbourhoods, one simple rule... and
complexity that appears out of nowhere.
