(* SOLUTION 08 · Unix Text Tools *)

let is_space c = c = ' ' || c = '\n' || c = '\t';;

let rec words = function
  | [] -> []
  | c :: rest when is_space c -> words rest
  | text ->
    let rec take_word = function
      | c :: rest when not (is_space c) ->
        let (w, r) = take_word rest in
        (c :: w, r)
      | rest -> ([], rest)
    in
    let (w, r) = take_word text in
    w :: words r;;

let rec uniq = function
  | a :: (b :: _ as rest) -> if a = b then uniq rest else a :: uniq rest
  | l -> l;;

let wc text =
  let rec lines = function
    | [] -> 0
    | c :: l -> (if c = '\n' then 1 else 0) + lines l
  in
  let rec count = function
    | [] -> 0
    | _ :: l -> 1 + count l
  in
  (lines text, count (words text), count text);;

let longest_word text =
  let rec len = function [] -> 0 | _ :: l -> 1 + len l in
  match words text with
  | [] -> failwith "longest_word: no words"
  | w :: rest ->
    let rec best b = function
      | [] -> b
      | x :: tl -> if len x > len b then best x tl else best b tl
    in
    best w rest;;
