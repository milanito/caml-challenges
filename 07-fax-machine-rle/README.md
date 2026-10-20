# 07 · The Fax Machine  ⭐⭐⭐☆☆

## The story

A fax machine scans a page and sends it over a phone line. A typical page is **mostly white**:
millions of white pixels, with a few black ones here and there. Sending every pixel one by one would
take forever. So fax machines use a beautifully simple trick, **run-length encoding (RLE)**:
instead of sending

```
WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW   (67 characters)
```

send

```
12W 1B 12W 3B 24W 1B 14W                                              (7 pairs)
```

Each **run** of identical symbols becomes a pair `(how many, which symbol)`.
The same idea is used in the BMP, TIFF and PCX image formats, and (in cleverer variants) in
JPEG and in many video codecs.

Your mission: write the encoder, the decoder, and an analyser. Then compress a drawing. ❤️

Read more: [Run-length encoding](https://en.wikipedia.org/wiki/Run-length_encoding) ·
[Fax](https://en.wikipedia.org/wiki/Fax) ·
[Data compression](https://en.wikipedia.org/wiki/Data_compression)

## Rules

Only `failwith` and `invalid_arg` are allowed. No `List` module.
Your functions must work on lists of **any** type (chars, ints, booleans...).

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `rle_encode : 'a list -> (int * 'a) list` | group consecutive equal elements into pairs `(count, element)` |
| 2 | `rle_decode : (int * 'a) list -> 'a list` | the inverse. Raises `Invalid_argument` if a count is `<= 0` |
| 3 | `longest_run : 'a list -> int * 'a` | the `(count, element)` of the **longest** run. If several runs tie, the **first** one wins. Raises `Failure` on the empty list |

```ocaml
# rle_encode [1; 1; 2; 3; 3; 3];;
- : (int * int) list = [(2, 1); (1, 2); (3, 3)]
# rle_encode ['a'; 'a'; 'b'; 'a'];;
- : (int * char) list = [(2, 'a'); (1, 'b'); (1, 'a')]
# rle_decode [(3, 'x'); (2, 'y')];;
- : char list = ['x'; 'x'; 'x'; 'y'; 'y']
# longest_run (explode "AACCCGTTTTGGA");;     (* a DNA sequence! *)
- : int * char = (4, 'T')
```

(`explode : string -> char list` is defined in `examples.ml`.)

### 🎨 Compress a drawing

At the end of `examples.ml`, a small bitmap (a heart) is compressed row by row using **your**
`rle_encode`, and the result is printed. Count: 63 pixels become only 19 pairs.
What would a plain black page look like? What would a checkerboard look like? (Think about when
RLE is a **bad** idea: that is a great exam question.)

## Test your code

```
cd 07-fax-machine-rle
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

For `rle_encode`, a pleasant way to think: *"I already know the encoding of the tail of the list.
Does my first element extend the first run of that encoding, or does it start a new run?"*

```ocaml
let rec rle_encode = function
  | [] -> []
  | e :: rest ->
    (match rle_encode rest with
     | (n, x) :: tl when x = e -> ...   (* e extends the first run *)
     | enc -> ...                       (* e starts a new run *)
    )
```

For `longest_run`, encode first, then look for the best pair.

</details>

## Next up

**08 · Unix Text Tools**: `wc`, `uniq`, `words`... the 1970s toolbox, rebuilt with lists.
