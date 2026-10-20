# 06 · Caesar's Secret  ⭐⭐⭐☆☆

> *"If he had anything confidential to say, he wrote it in cipher, that is, by so changing the order of
> the letters of the alphabet, that not a word could be made out."*
> — Suetonius, *Life of Julius Caesar* (about 120 AD), on how Caesar protected his military messages

## The story

Julius Caesar's trick was simple: replace every letter by the one **3 places further** in the alphabet
(`A→D`, `B→E`, ..., `Z→C`). To read the message, shift back by 3. The number of places (3) is the
**key**. Today it is trivially breakable (there are only 25 possible keys!), yet the same family of
ideas leads to the **Vigenère cipher**, to the **Enigma** machine, and eventually to modern cryptography.
A variant with key 13 is called **ROT13**; it is still used on forums to hide spoilers.

You are going to write the cipher, and then use it to **crack a secret message**. 🕵️

Read more: [Caesar cipher](https://en.wikipedia.org/wiki/Caesar_cipher) ·
[ROT13](https://en.wikipedia.org/wiki/ROT13) ·
[Frequency analysis](https://en.wikipedia.org/wiki/Frequency_analysis)

## Rules

Texts are **`char list`** values (`['H'; 'i']`), so you can use your list skills.
The test file gives you `explode : string -> char list` and `implode : char list -> string` to convert.

Allowed predefined functions: `failwith`, `invalid_arg`, and, **for this exercise only**,
`Char.code : char -> int` and `Char.chr : int -> char`.

```ocaml
# Char.code 'a';;
- : int = 97
# Char.chr 98;;
- : char = 'b'
```

Letters are `'a'..'z'` and `'A'..'Z'`. Every other character (spaces, digits, punctuation, accents...)
is left **unchanged**. Uppercase stays uppercase, lowercase stays lowercase.

## Your tasks

| # | Function | What it does |
|---|----------|--------------|
| 1 | `shift_char : int -> char -> char` | `shift_char k c` shifts one letter by `k` places, wrapping around the alphabet. `k` can be **negative or larger than 26** |
| 2 | `encrypt : int -> char list -> char list` | shift every character of a text |
| 3 | `decrypt : int -> char list -> char list` | undo `encrypt` with the same key |
| 4 | `rot13 : char list -> char list` | the ROT13 cipher |
| 5 | `secret_shift : int` | the mystery (see below) |

```ocaml
# shift_char 3 'a';;
- : char = 'd'
# shift_char 3 'z';;
- : char = 'c'
# shift_char (-3) 'a';;
- : char = 'x'
# implode (encrypt 3 (explode "Hello, World!"));;
- : string = "Khoor, Zruog!"
# implode (rot13 (explode "Hello, World!"));;
- : string = "Uryyb, Jbeyq!"
```

(`implode` and `explode` come from `examples.ml`, so load it first if you want to use them.)

### 🕵️ The mystery message

`examples.ml` contains a secret message called `mystery`, encrypted with a Caesar key that **you do not
know**. Once `encrypt` and `decrypt` work:

```ocaml
# brute_force mystery;;
```

This tries all 26 keys and prints the 26 candidate texts. Exactly one of them makes sense.
Put that key in `secret_shift` in `starter.ml` (the key such that `decrypt secret_shift` reveals the
message). And read the message to your teammates: it is an instruction. 😉

## Test your code

```
cd 06-caesar-cipher
utop
# #use "starter.ml";;
# #use "examples.ml";;
```

<details>
<summary>💡 Stuck? Click for a hint</summary>

For a lowercase letter, with `base = Char.code 'a'`:

1. position in the alphabet: `Char.code c - base` (a number from 0 to 25)
2. add the key, then bring it back into `0..25` with `mod 26`
3. go back to a character with `Char.chr (base + ...)`

Careful: in OCaml, `(-3) mod 26` is `-3`, not `23`! Add 26 and take `mod 26` again, to be safe.

`decrypt` should be one short line using `encrypt`.

</details>

## Next up

**07 · The Fax Machine**: how to send a picture over a slow phone line, with one beautiful idea.
