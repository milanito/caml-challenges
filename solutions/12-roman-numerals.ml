(* SOLUTION 12 · Roman Numerals *)

let table = [
  (1000, ['M']); (900, ['C'; 'M']); (500, ['D']); (400, ['C'; 'D']);
  (100, ['C']); (90, ['X'; 'C']); (50, ['L']); (40, ['X'; 'L']);
  (10, ['X']); (9, ['I'; 'X']); (5, ['V']); (4, ['I'; 'V']); (1, ['I'])
];;

let roman_of_int n =
  if n < 1 || n > 3999 then invalid_arg "roman_of_int: n must be in 1..3999"
  else
    let rec go n = function
      | [] -> []
      | (v, sym) :: rest as whole ->
        if n >= v then sym @ go (n - v) whole
        else go n rest
    in
    go n table;;

let value = function
  | 'I' -> 1 | 'V' -> 5 | 'X' -> 10 | 'L' -> 50
  | 'C' -> 100 | 'D' -> 500 | 'M' -> 1000
  | _ -> failwith "int_of_roman: invalid character";;

let rec int_of_roman = function
  | [] -> 0
  | [c] -> value c
  | c :: (d :: _ as rest) ->
    if value c < value d then int_of_roman rest - value c
    else int_of_roman rest + value c;;

let add_roman a b = roman_of_int (int_of_roman a + int_of_roman b);;

let longest_roman () =
  let rec length = function [] -> 0 | _ :: l -> 1 + length l in
  let rec go n (bn, bl) =
    if n > 3999 then bn
    else
      let l = length (roman_of_int n) in
      go (n + 1) (if l > bl then (n, l) else (bn, bl))
  in
  go 1 (1, 0);;
