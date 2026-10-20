(* 17 · Fold Everything
   RULE: the word  rec  is forbidden in YOUR answers.
   Only fold_left / fold_right (given below) may be recursive.
   Replace every  failwith "TODO"  with your own code. *)

(* Given to you:
   fold_left  f z [a; b; c] = f (f (f z a) b) c
   fold_right f [a; b; c] z = f a (f b (f c z)) *)
let rec fold_left f acc = function
  | [] -> acc
  | e :: l -> fold_left f (f acc e) l;;

let rec fold_right f lst acc =
  match lst with
  | [] -> acc
  | e :: l -> f e (fold_right f l acc);;

(* 1. number of elements *)
let length (lst : 'a list) : int = failwith "TODO";;

(* 2. sum of the elements *)
let sum (lst : int list) : int = failwith "TODO";;

(* 3. reverse a list *)
let rev (lst : 'a list) : 'a list = failwith "TODO";;

(* 4. apply f to every element *)
let map (f : 'a -> 'b) (lst : 'a list) : 'b list = failwith "TODO";;

(* 5. keep the elements that satisfy p *)
let filter (p : 'a -> bool) (lst : 'a list) : 'a list = failwith "TODO";;

(* 6. concatenate two lists *)
let append (l1 : 'a list) (l2 : 'a list) : 'a list = failwith "TODO";;

(* 7. concatenate a list of lists *)
let flatten (lsts : 'a list list) : 'a list = failwith "TODO";;

(* 8. the largest element. Raise Failure on the empty list *)
let max_elt (lst : 'a list) : 'a = failwith "TODO";;

(* 9. (elements satisfying p, the others), in their original order.
      ONE SINGLE FOLD. *)
let partition (p : 'a -> bool) (lst : 'a list) : 'a list * 'a list = failwith "TODO";;

(* 10. do all the elements satisfy p?   for_all p [] = true *)
let for_all (p : 'a -> bool) (lst : 'a list) : bool = failwith "TODO";;

(* 11. unzip [(1, 'a'); (2, 'b')] = ([1; 2], ['a'; 'b']) *)
let unzip (lst : ('a * 'b) list) : 'a list * 'b list = failwith "TODO";;

(* 12. THE BOSS: fold_left, built with fold_right only.
      Hint: let fold_right build a FUNCTION that waits for the accumulator. *)
let my_fold_left (f : 'a -> 'b -> 'a) (acc : 'a) (lst : 'b list) : 'a = failwith "TODO";;
