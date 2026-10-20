(* SOLUTION 09 · Pascal's Triangle *)

let next_row row =
  if row = [] then invalid_arg "next_row: empty row"
  else
    let rec sums = function
      | a :: (b :: _ as rest) -> (a + b) :: sums rest
      | _ -> []
    in
    (1 :: sums row) @ [1];;

let pascal n =
  if n < 0 then invalid_arg "pascal: n < 0"
  else
    let rec go i row =
      if i = n then [] else row :: go (i + 1) (next_row row)
    in
    go 0 [1];;

let binomial n k =
  if n < 0 || k < 0 || k > n then invalid_arg "binomial: need 0 <= k <= n"
  else
    let rec nth i = function
      | [] -> failwith "nth: too short"
      | e :: l -> if i = 0 then e else nth (i - 1) l
    in
    nth k (nth n (pascal (n + 1)));;
