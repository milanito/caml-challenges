(* 06 · Caesar's Secret
   Texts are char lists.  Allowed here: Char.code and Char.chr.
   Replace every  failwith "TODO"  with your own code. *)

(* 1. shift one letter by k places (k may be negative or > 26).
      Letters keep their case. Every other character is unchanged. *)
let shift_char (k : int) (c : char) : char = failwith "TODO";;

(* 2. shift every character of the text *)
let encrypt (k : int) (text : char list) : char list = failwith "TODO";;

(* 3. undo encrypt *)
let decrypt (k : int) (text : char list) : char list = failwith "TODO";;

(* 4. ROT13 *)
let rot13 (text : char list) : char list = failwith "TODO";;

(* 5. After your functions work, run   brute_force mystery;;   and read.
      Which key reveals the message?  Write it here. *)
let secret_shift : int = 0;;
