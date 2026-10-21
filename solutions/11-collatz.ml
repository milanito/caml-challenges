(* SOLUTION 11 · The Collatz Conjecture *)

let collatz_next n =
  if n mod 2 = 0 then n / 2 else 3 * n + 1;;

let collatz_seq n =
  if n < 1 then invalid_arg "collatz_seq: n < 1"
  else
    let rec go n =
      if n = 1 then [1] else n :: go (collatz_next n)
    in
    go n;;

let collatz_steps n =
  if n < 1 then invalid_arg "collatz_steps: n < 1"
  else
    let rec go n acc =
      if n = 1 then acc else go (collatz_next n) (acc + 1)
    in
    go n 0;;

let collatz_peak n =
  if n < 1 then invalid_arg "collatz_peak: n < 1"
  else
    let rec go n best =
      if n = 1 then best
      else
        let m = collatz_next n in
        go m (if m > best then m else best)
    in
    go n n;;

let longest_below limit =
  if limit < 2 then invalid_arg "longest_below: limit < 2"
  else
    let rec go n (bn, bs) =
      if n >= limit then (bn, bs)
      else
        let s = collatz_steps n in
        go (n + 1) (if s > bs then (n, s) else (bn, bs))
    in
    go 1 (1, 0);;
