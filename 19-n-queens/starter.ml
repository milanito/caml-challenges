(* 19 · The N-Queens Puzzle
   Columns are numbered 1..n.  A partial solution is the list of the columns of
   the queens already placed, the NEAREST row first.
   Allowed here: abs.
   Replace every  failwith "TODO"  with your own code. *)

(* 1. can a queen be put in column q of the next row?
      placed = columns of the previous rows, nearest row first.
      safe 3 [1] = true     safe 2 [1] = false (diagonal)     safe 3 [5; 1] = false *)
let safe (q : int) (placed : int list) : bool = failwith "TODO";;

(* 2. all the solutions of the n-queens problem: each is a list of n columns.
      The order of the solutions does not matter.
      Raise Invalid_argument if n < 1 *)
let queens (n : int) : int list list = failwith "TODO";;

(* 3. number of solutions *)
let count_queens (n : int) : int = failwith "TODO";;
