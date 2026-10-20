(* SOLUTION 19 · The N-Queens Puzzle *)

let safe q placed =
  let rec go d = function
    | [] -> true
    | c :: rest -> c <> q && abs (c - q) <> d && go (d + 1) rest
  in
  go 1 placed;;

let queens n =
  if n < 1 then invalid_arg "queens: n < 1"
  else
    (* all the ways to add a queen to one partial solution *)
    let rec extensions placed q =
      if q > n then []
      else if safe q placed then (q :: placed) :: extensions placed (q + 1)
      else extensions placed (q + 1)
    in
    (* extend every partial solution of a list *)
    let rec extend_all = function
      | [] -> []
      | placed :: rest -> extensions placed 1 @ extend_all rest
    in
    let rec place k =
      if k = 0 then [[]] else extend_all (place (k - 1))
    in
    place n;;

let count_queens n =
  let rec length = function [] -> 0 | _ :: l -> 1 + length l in
  length (queens n);;
