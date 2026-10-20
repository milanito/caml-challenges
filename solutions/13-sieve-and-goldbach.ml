(* SOLUTION 13 · Sieve & Goldbach *)

let rec range a b = if a > b then [] else a :: range (a + 1) b;;

let rec sieve = function
  | [] -> []
  | p :: rest ->
    let rec remove_multiples = function
      | [] -> []
      | x :: l -> if x mod p = 0 then remove_multiples l else x :: remove_multiples l
    in
    p :: sieve (remove_multiples rest);;

let primes_upto n = sieve (range 2 n);;

let rec mem x = function
  | [] -> false
  | e :: l -> e = x || mem x l;;

let goldbach n =
  if n < 4 || n mod 2 <> 0 then invalid_arg "goldbach: n must be even and >= 4"
  else
    let primes = primes_upto n in
    let rec go = function
      | [] -> failwith "goldbach: counterexample found, call a mathematician!"
      | p :: rest -> if mem (n - p) primes then (p, n - p) else go rest
    in
    go primes;;

let count_goldbach n =
  if n < 4 || n mod 2 <> 0 then invalid_arg "count_goldbach: n must be even and >= 4"
  else
    let primes = primes_upto n in
    let rec go = function
      | [] -> 0
      | p :: rest ->
        if p > n - p then 0
        else (if mem (n - p) primes then 1 else 0) + go rest
    in
    go primes;;

let twin_primes n =
  let rec go = function
    | p :: (q :: _ as rest) -> if q = p + 2 then (p, q) :: go rest else go rest
    | _ -> []
  in
  go (primes_upto n);;
