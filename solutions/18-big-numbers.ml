(* SOLUTION 18 · Big Numbers *)

let rec big_of_int n =
  if n < 0 then invalid_arg "big_of_int: n < 0"
  else if n < 10 then [n]
  else (n mod 10) :: big_of_int (n / 10);;

let add_big a b =
  let rec go carry a b =
    match a, b with
    | [], [] -> if carry = 0 then [] else [carry]
    | x :: a', [] | [], x :: a' ->
      let s = x + carry in
      (s mod 10) :: go (s / 10) a' []
    | x :: a', y :: b' ->
      let s = x + y + carry in
      (s mod 10) :: go (s / 10) a' b'
  in
  go 0 a b;;

let mul_small a k =
  if k < 0 then invalid_arg "mul_small: k < 0"
  else if k = 0 then [0]
  else
    let rec go carry = function
      | [] -> if carry = 0 then [] else (carry mod 10) :: go (carry / 10) []
      | d :: rest ->
        let p = d * k + carry in
        (p mod 10) :: go (p / 10) rest
    in
    go 0 a;;

let factorial_big n =
  if n < 0 then invalid_arg "factorial_big: n < 0"
  else
    let rec go i acc = if i > n then acc else go (i + 1) (mul_small acc i) in
    go 1 [1];;

let fib_big n =
  if n < 0 then invalid_arg "fib_big: n < 0"
  else
    let rec go i a b = if i = 0 then a else go (i - 1) b (add_big a b) in
    go n [0] [1];;

let power_big k e =
  if k < 0 || e < 0 then invalid_arg "power_big: negative argument"
  else
    let rec go e acc = if e = 0 then acc else go (e - 1) (mul_small acc k) in
    go e [1];;

let rec digit_sum = function
  | [] -> 0
  | d :: rest -> d + digit_sum rest;;
