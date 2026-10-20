(* 15 · All the Ways
   Replace every  failwith "TODO"  with your own code.
   (No List module: write your own map / flatten helpers if you need them.) *)

(* 1. all the subsets of a list, original order kept inside each subset.
      The order of the subsets in the result does not matter. *)
let subsets (lst : 'a list) : 'a list list = failwith "TODO";;

(* 2. all the permutations of a list (elements are all different).
      The order of the permutations in the result does not matter. *)
let permutations (lst : 'a list) : 'a list list = failwith "TODO";;

(* 3. all the subsets with exactly k elements (original order kept).
      Raise Invalid_argument if k < 0 *)
let combinations (k : int) (lst : 'a list) : 'a list list = failwith "TODO";;

(* 4. Travelling salesman: length of the shortest round trip that starts at
      start, visits every city of others exactly once, and returns to start.
      shortest_tour dist start [] = 0 *)
let shortest_tour (dist : 'a -> 'a -> int) (start : 'a) (others : 'a list) : int =
  failwith "TODO";;
