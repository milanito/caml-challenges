(* SOLUTION 17 · Fold Everything *)

let rec fold_left f acc = function
  | [] -> acc
  | e :: l -> fold_left f (f acc e) l;;

let rec fold_right f lst acc =
  match lst with
  | [] -> acc
  | e :: l -> f e (fold_right f l acc);;

let length lst = fold_left (fun n _ -> n + 1) 0 lst;;

let sum lst = fold_left (fun a b -> a + b) 0 lst;;

let rev lst = fold_left (fun acc e -> e :: acc) [] lst;;

let map f lst = fold_right (fun e acc -> f e :: acc) lst [];;

let filter p lst = fold_right (fun e acc -> if p e then e :: acc else acc) lst [];;

let append l1 l2 = fold_right (fun e acc -> e :: acc) l1 l2;;

let flatten lsts = fold_right append lsts [];;

let max_elt lst =
  match lst with
  | [] -> failwith "max_elt: empty list"
  | h :: t -> fold_left (fun m e -> if e > m then e else m) h t;;

let partition p lst =
  fold_right
    (fun e (yes, no) -> if p e then (e :: yes, no) else (yes, e :: no))
    lst ([], []);;

let for_all p lst = fold_left (fun ok e -> ok && p e) true lst;;

let unzip lst =
  fold_right (fun (a, b) (l1, l2) -> (a :: l1, b :: l2)) lst ([], []);;

let my_fold_left f acc lst =
  fold_right (fun e k -> fun a -> k (f a e)) lst (fun a -> a) acc;;
