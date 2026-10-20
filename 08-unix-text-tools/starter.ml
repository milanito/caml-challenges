(* 08 · Unix Text Tools
   A text is a char list. Whitespace = ' ' or '\n' or '\t'.
   Replace every  failwith "TODO"  with your own code. *)

(* 1. split a text into words (never returns an empty word) *)
let words (text : char list) : char list list = failwith "TODO";;

(* 2. remove CONSECUTIVE duplicates: uniq [1;1;2;2;2;1;3;3] = [1;2;1;3] *)
let uniq (lst : 'a list) : 'a list = failwith "TODO";;

(* 3. (number of '\n', number of words, number of characters) *)
let wc (text : char list) : int * int * int = failwith "TODO";;

(* 4. the longest word (the first one on a tie). Raise Failure if there are no words *)
let longest_word (text : char list) : char list = failwith "TODO";;
