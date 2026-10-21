(* SOLUTION 10 · Merge Sort *)

let rec merge order l1 l2 =
  match l1, l2 with
  | [], l | l, [] -> l
  | x :: r1, y :: r2 ->
    if order x y then x :: merge order r1 l2
    else y :: merge order l1 r2;;

let rec halve = function
  | [] -> ([], [])
  | [x] -> ([x], [])
  | x :: y :: rest ->
    let (a, b) = halve rest in
    (x :: a, y :: b);;

let rec merge_sort order lst =
  match lst with
  | [] | [_] -> lst
  | _ ->
    let (a, b) = halve lst in
    merge order (merge_sort order a) (merge_sort order b);;
