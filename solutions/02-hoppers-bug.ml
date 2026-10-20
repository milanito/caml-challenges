(* SOLUTION 02 · Hopper's Bug *)

let rec mem x = function
  | [] -> false
  | e :: l -> e = x || mem x l;;

let index_of x lst =
  let rec go i = function
    | [] -> failwith "index_of: not found"
    | e :: l -> if e = x then i else go (i + 1) l
  in
  go 1 lst;;

let positions x lst =
  let rec go i = function
    | [] -> []
    | e :: l -> if e = x then i :: go (i + 1) l else go (i + 1) l
  in
  go 1 lst;;

let rec remove_first x = function
  | [] -> []
  | e :: l -> if e = x then l else e :: remove_first x l;;

let rec squash x = function
  | [] -> []
  | e :: l -> if e = x then squash x l else e :: squash x l;;
