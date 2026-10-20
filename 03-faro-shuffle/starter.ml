(* 03 · The Faro Shuffle
   Replace every  failwith "TODO"  with your own code. *)

(* Given to you: the length of a list (you wrote it in exercise 01) *)
let rec length = function
  | [] -> 0
  | _ :: l -> 1 + length l;;

(* 1. the first n elements.  n <= 0 -> []   n too big -> the whole list *)
let take (n : int) (lst : 'a list) : 'a list = failwith "TODO";;

(* 2. everything except the first n elements *)
let drop (n : int) (lst : 'a list) : 'a list = failwith "TODO";;

(* 3. (take n lst, drop n lst) *)
let split_at (n : int) (lst : 'a list) : 'a list * 'a list = failwith "TODO";;

(* 4. cut a deck: the top n cards go to the bottom.
      cut 2 [1;2;3;4;5] = [3;4;5;1;2] *)
let cut (n : int) (deck : 'a list) : 'a list = failwith "TODO";;

(* 5. interleave two lists: a1; b1; a2; b2; ...
      when one list is exhausted, the rest of the other follows *)
let riffle (a : 'a list) (b : 'a list) : 'a list = failwith "TODO";;

(* 6. perfect shuffle: riffle (first half) (second half), first half first.
      Raise Invalid_argument if the deck has an odd number of cards. *)
let faro (deck : 'a list) : 'a list = failwith "TODO";;

(* 7. how many perfect shuffles bring the deck back to its original order?
      (at least 1) *)
let faro_period (deck : 'a list) : int = failwith "TODO";;
