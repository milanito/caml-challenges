(* SOLUTION 01 · Ada's Notes *)

let rec sum = function
  | [] -> 0
  | e :: l -> e + sum l;;

let rec length = function
  | [] -> 0
  | _ :: l -> 1 + length l;;

let rec last = function
  | [] -> failwith "last: empty list"
  | [e] -> e
  | _ :: l -> last l;;

let average lst =
  if lst = [] then invalid_arg "average: empty list"
  else sum lst / length lst;;

let rec range a b =
  if a > b then []
  else a :: range (a + 1) b;;
