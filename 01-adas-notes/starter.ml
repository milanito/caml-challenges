(* 01 · Ada's Notes
   Replace every  failwith "TODO"  with your own code.
   Do not rename the functions: the tests look for these exact names. *)

(* 1. sum of all the elements. sum [] = 0 *)
let sum (lst : int list) : int = failwith "TODO";;

(* 2. number of elements *)
let length (lst : 'a list) : int = failwith "TODO";;

(* 3. last element. Raise Failure if the list is empty *)
let last (lst : 'a list) : 'a = failwith "TODO";;

(* 4. integer average. Raise Invalid_argument if the list is empty.
      Hint: reuse sum and length *)
let average (lst : int list) : int = failwith "TODO";;

(* 5. range a b = [a; a+1; ...; b]   ([] if a > b) *)
let range (a : int) (b : int) : int list = failwith "TODO";;
