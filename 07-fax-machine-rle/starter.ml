(* 07 · The Fax Machine
   Replace every  failwith "TODO"  with your own code. *)

(* 1. group consecutive equal elements: (how many, which element)
      rle_encode [1; 1; 2; 3; 3; 3] = [(2, 1); (1, 2); (3, 3)] *)
let rle_encode (lst : 'a list) : (int * 'a) list = failwith "TODO";;

(* 2. the inverse of rle_encode.
      Raise Invalid_argument if a count is <= 0 *)
let rle_decode (code : (int * 'a) list) : 'a list = failwith "TODO";;

(* 3. (count, element) of the longest run. First one wins on a tie.
      Raise Failure on the empty list. *)
let longest_run (lst : 'a list) : int * 'a = failwith "TODO";;
