(* SOLUTION 16 · Cellular Automata *)

let rec power2 n = if n = 0 then 1 else 2 * power2 (n - 1);;

let rule_bit rule i =
  if rule < 0 || rule > 255 then invalid_arg "rule_bit: rule must be in 0..255"
  else if i < 0 || i > 7 then invalid_arg "rule_bit: i must be in 0..7"
  else (rule / power2 i) mod 2 = 1;;

let single_cell width =
  if width < 1 then invalid_arg "single_cell: width < 1"
  else
    let rec go i = if i >= width then [] else (i = width / 2) :: go (i + 1) in
    go 0;;

let bit b = if b then 1 else 0;;

let step rule cells =
  let rec go left = function
    | [] -> []
    | c :: rest ->
      let right = (match rest with [] -> false | r :: _ -> r) in
      rule_bit rule (4 * bit left + 2 * bit c + bit right) :: go c rest
  in
  go false cells;;

let rec run rule n cells =
  if n < 0 then invalid_arg "run: n < 0"
  else if n = 0 then [cells]
  else cells :: run rule (n - 1) (step rule cells);;

let populations rule width n =
  let rec count = function
    | [] -> 0
    | b :: l -> bit b + count l
  in
  let rec counts = function
    | [] -> []
    | row :: rows -> count row :: counts rows
  in
  counts (run rule n (single_cell width));;
