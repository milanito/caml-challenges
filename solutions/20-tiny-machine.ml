(* SOLUTION 20 · The Tiny Machine *)

let run program =
  let rec rev acc = function [] -> acc | x :: r -> rev (x :: acc) r in
  (* after a '[' whose cell is 0: skip to just after the matching ']'.
     returns (new before, new after) *)
  let rec skip_fwd depth before after =
    match after with
    | [] -> failwith "unmatched ["
    | ']' :: rest ->
      if depth = 0 then (']' :: before, rest)
      else skip_fwd (depth - 1) (']' :: before) rest
    | '[' :: rest -> skip_fwd (depth + 1) ('[' :: before) rest
    | c :: rest -> skip_fwd depth (c :: before) rest
  in
  (* at a ']' whose cell is not 0: go back to the matching '['.
     returns (new before, new after) where after starts with '[' *)
  let rec skip_back depth before after =
    match before with
    | [] -> failwith "unmatched ]"
    | '[' :: rest ->
      if depth = 0 then (rest, '[' :: after)
      else skip_back (depth - 1) rest ('[' :: after)
    | ']' :: rest -> skip_back (depth + 1) rest (']' :: after)
    | c :: rest -> skip_back depth rest (c :: after)
  in
  let rec exec before after (left, cur, right) out =
    match after with
    | [] -> rev [] out
    | instr :: rest ->
      (match instr with
       | '>' ->
         let tape' =
           (match right with
            | [] -> (cur :: left, 0, [])
            | r :: rs -> (cur :: left, r, rs)) in
         exec (instr :: before) rest tape' out
       | '<' ->
         let tape' =
           (match left with
            | [] -> ([], 0, cur :: right)
            | l :: ls -> (ls, l, cur :: right)) in
         exec (instr :: before) rest tape' out
       | '+' -> exec (instr :: before) rest (left, (cur + 1) mod 256, right) out
       | '-' -> exec (instr :: before) rest (left, (cur + 255) mod 256, right) out
       | '.' -> exec (instr :: before) rest (left, cur, right) (Char.chr cur :: out)
       | '[' ->
         if cur = 0 then
           let (b, a) = skip_fwd 0 ('[' :: before) rest in
           exec b a (left, cur, right) out
         else exec ('[' :: before) rest (left, cur, right) out
       | ']' ->
         if cur = 0 then exec (']' :: before) rest (left, cur, right) out
         else
           let (b, a) = skip_back 0 before (']' :: rest) in
           exec b a (left, cur, right) out
       | _ -> exec (instr :: before) rest (left, cur, right) out)
  in
  exec [] program ([], 0, []) [];;

(* 72 = 8 * 9, then +33 = 105 ('i'), then a new cell with 33 ('!') *)
let my_hi_program =
  "++++++++[>+++++++++<-]>." ^ String.make 33 '+' ^ "." ^ ">" ^ String.make 33 '+' ^ ".";;

(* cell 1 = 65 ('A'), cell 2 = 26 counter *)
let my_alphabet_program =
  "++++++++[>++++++++<-]>+>" ^ String.make 26 '+' ^ "[<.+>-]";;
