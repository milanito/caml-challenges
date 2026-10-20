(* SOLUTION 15 · All the Ways *)

let rec map f = function
  | [] -> []
  | e :: l -> f e :: map f l;;

let rec flatten = function
  | [] -> []
  | l :: r -> l @ flatten r;;

let rec subsets = function
  | [] -> [[]]
  | e :: rest ->
    let s = subsets rest in
    s @ map (fun x -> e :: x) s;;

let rec insert_everywhere x = function
  | [] -> [[x]]
  | e :: rest as l -> (x :: l) :: map (fun p -> e :: p) (insert_everywhere x rest);;

let rec permutations = function
  | [] -> [[]]
  | e :: rest -> flatten (map (insert_everywhere e) (permutations rest));;

let rec combinations k lst =
  if k < 0 then invalid_arg "combinations: k < 0"
  else if k = 0 then [[]]
  else
    match lst with
    | [] -> []
    | e :: rest ->
      map (fun c -> e :: c) (combinations (k - 1) rest) @ combinations k rest;;

let shortest_tour dist start others =
  if others = [] then 0
  else
    let rec path_length from = function
      | [] -> dist from start
      | c :: rest -> dist from c + path_length c rest
    in
    match permutations others with
    | [] -> failwith "shortest_tour: impossible"
    | p :: ps ->
      let rec best b = function
        | [] -> b
        | q :: qs ->
          let l = path_length start q in
          best (if l < b then l else b) qs
      in
      best (path_length start p) ps;;
