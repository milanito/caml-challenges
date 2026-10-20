(* SOLUTION 14 · The Matrix Lab *)

let rec transpose = function
  | [] | [] :: _ -> []
  | rows ->
    let rec heads = function
      | [] -> []
      | (h :: _) :: r -> h :: heads r
      | [] :: _ -> failwith "transpose: not rectangular"
    in
    let rec tails = function
      | [] -> []
      | (_ :: t) :: r -> t :: tails r
      | [] :: _ -> failwith "transpose: not rectangular"
    in
    heads rows :: transpose (tails rows);;

let rec dot u v =
  match u, v with
  | [], [] -> 0
  | x :: u', y :: v' -> x * y + dot u' v'
  | _ -> invalid_arg "dot: different lengths";;

let mat_mul a b =
  let cols = transpose b in
  let rec row_times r = function
    | [] -> []
    | c :: cs -> dot r c :: row_times r cs
  in
  let rec go = function
    | [] -> []
    | r :: rs -> row_times r cols :: go rs
  in
  go a;;

let identity n =
  let rec row i j =
    if j > n then [] else (if i = j then 1 else 0) :: row i (j + 1)
  in
  let rec go i = if i > n then [] else row i 1 :: go (i + 1) in
  go 1;;

let mat_pow m k =
  if k < 0 then invalid_arg "mat_pow: k < 0"
  else
    let rec length = function [] -> 0 | _ :: l -> 1 + length l in
    let rec go k =
      if k = 0 then identity (length m)
      else if k mod 2 = 0 then
        let h = go (k / 2) in
        mat_mul h h
      else mat_mul m (go (k - 1))
    in
    go k;;

let fib_matrix n =
  match mat_pow [[1; 1]; [1; 0]] n with
  | (_ :: f :: _) :: _ -> f
  | _ -> failwith "fib_matrix: impossible";;

let rotate_cw m =
  let rec rev acc = function [] -> acc | x :: r -> rev (x :: acc) r in
  let rec rev_rows = function [] -> [] | r :: rs -> rev [] r :: rev_rows rs in
  rev_rows (transpose m);;
