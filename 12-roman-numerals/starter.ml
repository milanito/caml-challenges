(* 12 · Roman Numerals
   A numeral is a char list, e.g. ['M'; 'C'; 'M'; 'X'; 'C'; 'I'; 'V'].
   Replace every  failwith "TODO"  with your own code. *)

(* 1. numeral of a number in 1..3999 (Invalid_argument otherwise) *)
let roman_of_int (n : int) : char list = failwith "TODO";;

(* 2. value of a numeral (Failure if a character is not one of I V X L C D M) *)
let int_of_roman (numeral : char list) : int = failwith "TODO";;

(* 3. add two numerals: XIV + XXVIII = XLII
      Invalid_argument if the result is above 3999 *)
let add_roman (a : char list) (b : char list) : char list = failwith "TODO";;

(* 4. the number in 1..3999 whose numeral is the longest.
      Call it with  longest_roman ();;   *)
let longest_roman () : int = failwith "TODO";;
