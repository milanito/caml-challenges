(* 09 · Pascal's Triangle
   Replace every  failwith "TODO"  with your own code. *)

(* 1. the next row of the triangle.
      next_row [1; 3; 3; 1] = [1; 4; 6; 4; 1]
      Raise Invalid_argument on the empty list. *)
let next_row (row : int list) : int list = failwith "TODO";;

(* 2. the first n rows: pascal 3 = [[1]; [1; 1]; [1; 2; 1]]
      pascal 0 = []   Raise Invalid_argument if n < 0 *)
let pascal (n : int) : int list list = failwith "TODO";;

(* 3. binomial n k = k among n (row n, element k, both counted from 0).
      Raise Invalid_argument unless 0 <= k <= n *)
let binomial (n : int) (k : int) : int = failwith "TODO";;
