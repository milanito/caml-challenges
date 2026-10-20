(* SOLUTION 04 · Rabbits of Fibonacci *)

let rec fib n =
  if n < 0 then invalid_arg "fib: n < 0"
  else if n < 2 then n
  else fib (n - 1) + fib (n - 2);;

let fib_list n =
  if n < 0 then invalid_arg "fib_list: n < 0"
  else
    let rec go a b k =
      if k = 0 then [] else a :: go b (a + b) (k - 1)
    in
    go 0 1 n;;

let fib_fast n =
  if n < 0 then invalid_arg "fib_fast: n < 0"
  else
    let rec go a b k =
      if k = 0 then a else go b (a + b) (k - 1)
    in
    go 0 1 n;;

let sum_even_fibs limit =
  let rec go a b acc =
    if a > limit then acc
    else go b (a + b) (if a mod 2 = 0 then acc + a else acc)
  in
  go 0 1 0;;
