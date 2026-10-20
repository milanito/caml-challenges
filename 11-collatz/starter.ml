(* 11 · The Collatz Conjecture
   Replace every  failwith "TODO"  with your own code. *)

(* 1. one step: n/2 if n is even, 3n+1 if n is odd *)
let collatz_next (n : int) : int = failwith "TODO";;

(* 2. the whole sequence from n down to 1 (both included).
      collatz_seq 6 = [6; 3; 10; 5; 16; 8; 4; 2; 1]
      Raise Invalid_argument if n < 1 *)
let collatz_seq (n : int) : int list = failwith "TODO";;

(* 3. number of steps to reach 1: collatz_steps 6 = 8, collatz_steps 1 = 0
      Raise Invalid_argument if n < 1.  Do not build the list: just count! *)
let collatz_steps (n : int) : int = failwith "TODO";;

(* 4. the highest value reached by the sequence of n
      collatz_peak 27 = 9232 *)
let collatz_peak (n : int) : int = failwith "TODO";;

(* 5. (n, steps): the n in [1, limit-1] with the most steps.
      Smallest n on a tie.  Raise Invalid_argument if limit < 2 *)
let longest_below (limit : int) : int * int = failwith "TODO";;
