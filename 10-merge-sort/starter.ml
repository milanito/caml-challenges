(* 10 · Merge Sort
   order x y = true  means  "x may come before y".
   Replace every  failwith "TODO"  with your own code. *)

(* 1. merge two lists that are ALREADY sorted according to order *)
let merge (order : 'a -> 'a -> bool) (l1 : 'a list) (l2 : 'a list) : 'a list =
  failwith "TODO";;

(* 2. deal the elements alternately into two lists:
      halve [1; 2; 3; 4; 5] = ([1; 3; 5], [2; 4]) *)
let halve (lst : 'a list) : 'a list * 'a list = failwith "TODO";;

(* 3. merge sort: halve, sort each half, merge *)
let merge_sort (order : 'a -> 'a -> bool) (lst : 'a list) : 'a list =
  failwith "TODO";;
