(* 02 · Hopper's Bug
   Replace every  failwith "TODO"  with your own code.
   Remember: positions start at 1. *)

(* 1. is x in the list? *)
let mem (x : 'a) (lst : 'a list) : bool = failwith "TODO";;

(* 2. position (from 1) of the first occurrence of x.
      Raise Failure if x is not in the list. *)
let index_of (x : 'a) (lst : 'a list) : int = failwith "TODO";;

(* 3. positions (from 1) of ALL the occurrences of x, in increasing order *)
let positions (x : 'a) (lst : 'a list) : int list = failwith "TODO";;

(* 4. remove the first occurrence of x (if there is one) *)
let remove_first (x : 'a) (lst : 'a list) : 'a list = failwith "TODO";;

(* 5. remove every occurrence of x *)
let squash (x : 'a) (lst : 'a list) : 'a list = failwith "TODO";;
