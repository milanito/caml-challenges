(* SOLUTION 07 · The Fax Machine *)

let rec rle_encode = function
  | [] -> []
  | e :: rest ->
    (match rle_encode rest with
     | (n, x) :: tl when x = e -> (n + 1, x) :: tl
     | enc -> (1, e) :: enc);;

let rec rle_decode = function
  | [] -> []
  | (n, x) :: rest ->
    if n <= 0 then invalid_arg "rle_decode: count <= 0"
    else
      let rec repeat k = if k = 0 then [] else x :: repeat (k - 1) in
      repeat n @ rle_decode rest;;

let longest_run lst =
  match rle_encode lst with
  | [] -> failwith "longest_run: empty list"
  | first :: rest ->
    let rec best (bn, bx) = function
      | [] -> (bn, bx)
      | (n, x) :: tl -> if n > bn then best (n, x) tl else best (bn, bx) tl
    in
    best first rest;;
