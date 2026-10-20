(* 20 · The Tiny Machine  (Brainf*ck interpreter)
   Cells are numbers 0..255 (wrap around), the tape is infinite in both directions,
   every cell starts at 0.
   Instructions:  > < + - . [ ]      every other character is ignored.
   Allowed here: Char.chr and Char.code.
   Replace every  failwith "TODO"  with your own code. *)

(* 1. run the program, return the characters it outputs.
      Raise Failure when it needs to jump to a bracket that has no match. *)
let run (program : char list) : char list = failwith "TODO";;

(* 2. a Brainf*ck program (a string) that outputs  Hi! *)
let my_hi_program : string = "TODO";;

(* 3. a Brainf*ck program that outputs  ABCDEFGHIJKLMNOPQRSTUVWXYZ *)
let my_alphabet_program : string = "TODO";;
