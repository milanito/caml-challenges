(* SOLUTION 03 · The Faro Shuffle *)

let rec length = function
  | [] -> 0
  | _ :: l -> 1 + length l;;

let rec take n lst =
  match lst with
  | [] -> []
  | e :: l -> if n <= 0 then [] else e :: take (n - 1) l;;

let rec drop n lst =
  match lst with
  | [] -> []
  | _ :: l as whole -> if n <= 0 then whole else drop (n - 1) l;;

let split_at n lst = (take n lst, drop n lst);;

let cut n deck = drop n deck @ take n deck;;

let rec riffle a b =
  match a, b with
  | [], l | l, [] -> l
  | x :: a', y :: b' -> x :: y :: riffle a' b';;

let faro deck =
  let n = length deck in
  if n mod 2 = 1 then invalid_arg "faro: odd number of cards"
  else riffle (take (n / 2) deck) (drop (n / 2) deck);;

let faro_period deck =
  let rec go k current =
    let next = faro current in
    if next = deck then k else go (k + 1) next
  in
  go 1 deck;;
