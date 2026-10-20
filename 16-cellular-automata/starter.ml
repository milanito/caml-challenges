(* 16 · Cellular Automata
   cells are booleans (true = alive).  Outside the row, cells are dead.
   Replace every  failwith "TODO"  with your own code. *)

(* Given to you: power2 3 = 8.   The i-th bit of r is (r / power2 i) mod 2 *)
let rec power2 n = if n = 0 then 1 else 2 * power2 (n - 1);;

(* 1. is bit i of the rule number set?
      Raise Invalid_argument unless 0 <= rule <= 255 and 0 <= i <= 7 *)
let rule_bit (rule : int) (i : int) : bool = failwith "TODO";;

(* 2. width dead cells, with one living cell at position width / 2.
      single_cell 7 is  . . . # . . .
      Raise Invalid_argument if width < 1 *)
let single_cell (width : int) : bool list = failwith "TODO";;

(* 3. one tick of the automaton: the next row (same length).
      The neighbourhood (left, me, right) is the number 4*l + 2*me + r
      with l, me, r in {0, 1}; the new state of the cell is rule_bit rule that_number *)
let step (rule : int) (cells : bool list) : bool list = failwith "TODO";;

(* 4. run rule n cells = the n+1 successive rows (the initial one + n ticks).
      Raise Invalid_argument if n < 0 *)
let run (rule : int) (n : int) (cells : bool list) : bool list list = failwith "TODO";;

(* 5. starting from single_cell width, the number of living cells in each of
      the n+1 rows *)
let populations (rule : int) (width : int) (n : int) : int list = failwith "TODO";;
