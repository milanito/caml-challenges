(* SOLUTION 05 · Babbage's Engine *)

let twice f x = f (f x);;

let compose f g = fun x -> f (g x);;

let rec iterate f n x =
  if n < 0 then invalid_arg "iterate: n < 0"
  else if n = 0 then x
  else iterate f (n - 1) (f x);;

let tabulate f n =
  if n < 0 then invalid_arg "tabulate: n < 0"
  else
    let rec go i = if i >= n then [] else f i :: go (i + 1) in
    go 0;;

let rec differences = function
  | a :: (b :: _ as rest) -> (b - a) :: differences rest
  | _ -> [];;
