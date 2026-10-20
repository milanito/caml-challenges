(* ===== test helpers (do not edit) ===== *)
let passed = ref 0;;
let total = ref 0;;
let check name ok =
  incr total;
  if ok then incr passed;
  Printf.printf "%s %s\n" (if ok then "[ OK ]" else "[FAIL]") name;;
let raises_invalid f = try ignore (f ()); false with Invalid_argument _ -> true | _ -> false;;
let raises_failure f = try ignore (f ()); false with Failure _ -> true | _ -> false;;
let summary expected =
  Printf.printf "\n%d/%d checks passed" !passed expected;
  if !passed = expected then print_endline "   Perfect!" else print_endline "";
  if !total < expected then
    Printf.printf "(%d check(s) could not even run: look for error messages above)\n" (expected - !total);;
(* ===== end of helpers ===== *)

(* ===== Exercise 20 · The Tiny Machine ===== *)

let explode s = List.init (String.length s) (String.get s);;
let implode l = String.concat "" (List.map (String.make 1) l);;

(* runs a program given as a string, returns the output as a string *)
let run_s s = implode (run (explode s));;
(* runs a program given as a string, returns the codes of the output chars *)
let codes s = List.map Char.code (run (explode s));;

(* The famous "Hello World!" program (from Wikipedia) *)
let hello_world =
  "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.";;

(* a program that prints the digits 0123456789 *)
let digits = "++++++++[>++++++<-]>>++++++++++[<.+>-]";;

(* a program with comments *)
let commented = "this is a comment + so +. is this";;

let () = check "empty program" (run [] = []);;
let () = check "'+' then '.': one char of code 1" (codes "+." = [1]);;
let () = check "'+++.' outputs code 3" (codes "+++." = [3]);;
let () = check "'.' outputs a 0" (codes "." = [0]);;
let () = check "two outputs" (codes "++.+." = [2; 3]);;
let () = check "'-' wraps around to 255" (codes "-." = [255]);;
let () = check "256 times '+' wraps around to 0" (codes (String.make 256 '+' ^ ".") = [0]);;
let () = check "257 times '+' wraps around to 1" (codes (String.make 257 '+' ^ ".") = [1]);;
let () = check "'>' goes to a fresh cell" (codes "+>." = [0]);;
let () = check "'<' goes to a fresh cell (infinite tape on the left)" (codes "+<." = [0]);;
let () = check "cells keep their own value" (codes "+<++.>" = [2]);;
let () = check "going back to the first cell" (codes "+<++>." = [1]);;
let () = check "going far to the left and back" (codes "<<<+++>>>." = [0]);;
let () = check "going far to the right and back" (codes "++>>>+++<<<." = [2]);;
let () = check "'[' skips the loop if the cell is 0" (codes "[.]+." = [1]);;
let () = check "nested loop skipped when the cell is 0" (codes "[[+]]+." = [1]);;
let () = check "loop '+++[.-]' counts down" (codes "+++[.-]" = [3; 2; 1]);;
let () = check "loop multiplication: 8 * 8 + 1 = 65" (codes "++++++++[>++++++++<-]>+." = [65]);;
let () = check "nested loops: 2 * 3 * 4 = 24" (codes "++[>+++[>++++<-]<-]>>." = [24]);;
let () = check "nested loops with wrap-around: 8 * 8 * 8 = 512 = 0 mod 256"
    (codes "++++++++[>++++++++[>++++++++[>++++++++<-]<-]<-]>>>." = [0]);;
let () = check "characters of the output: 'A'" (run (explode "++++++++[>++++++++<-]>+.") = ['A']);;
let () = check "other characters are ignored" (codes commented = [2]);;
let () = check "',' is ignored" (codes ",+,.," = [1]);;
let () = check "digits program" (run_s digits = "0123456789");;
let () = check "Hello World!" (run_s hello_world = "Hello World!\n");;
let () = check "unmatched '[' raises Failure" (raises_failure (fun () -> run (explode "[+")));;
let () = check "unmatched ']' raises Failure" (raises_failure (fun () -> run (explode "+]")));;

let () = check "my_hi_program outputs Hi!" (run_s my_hi_program = "Hi!");;
let () = check "my_alphabet_program outputs the alphabet"
    (run_s my_alphabet_program = "ABCDEFGHIJKLMNOPQRSTUVWXYZ");;
let () = check "my_hi_program uses at least one loop (be smart!)"
    (List.mem '[' (explode my_hi_program) && List.mem ']' (explode my_hi_program));;

let () = summary 30;;
