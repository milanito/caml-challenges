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

(* ===== Exercise 11 · The Collatz Conjecture ===== *)

let () = check "collatz_next 6 = 3" (collatz_next 6 = 3);;
let () = check "collatz_next 7 = 22" (collatz_next 7 = 22);;
let () = check "collatz_next 1 = 4" (collatz_next 1 = 4);;

let () = check "collatz_seq 1" (collatz_seq 1 = [1]);;
let () = check "collatz_seq 2" (collatz_seq 2 = [2; 1]);;
let () = check "collatz_seq 6" (collatz_seq 6 = [6; 3; 10; 5; 16; 8; 4; 2; 1]);;
let () = check "collatz_seq 7"
    (collatz_seq 7 = [7; 22; 11; 34; 17; 52; 26; 13; 40; 20; 10; 5; 16; 8; 4; 2; 1]);;
let () = check "collatz_seq 0 raises Invalid_argument" (raises_invalid (fun () -> collatz_seq 0));;
let () = check "collatz_seq (-5) raises Invalid_argument" (raises_invalid (fun () -> collatz_seq (-5)));;

let () = check "collatz_steps 1 = 0" (collatz_steps 1 = 0);;
let () = check "collatz_steps 6 = 8" (collatz_steps 6 = 8);;
let () = check "collatz_steps 9 = 19" (collatz_steps 9 = 19);;
let () = check "collatz_steps 27 = 111" (collatz_steps 27 = 111);;
let () = check "collatz_steps 97 = 118" (collatz_steps 97 = 118);;
let () = check "collatz_steps 0 raises Invalid_argument" (raises_invalid (fun () -> collatz_steps 0));;
let () = check "collatz_steps agrees with collatz_seq on 1..200"
    (let rec length = function [] -> 0 | _ :: l -> 1 + length l in
     let rec all n = n > 200 || (collatz_steps n = length (collatz_seq n) - 1 && all (n + 1)) in
     all 1);;

let () = check "collatz_peak 1 = 1" (collatz_peak 1 = 1);;
let () = check "collatz_peak 6 = 16" (collatz_peak 6 = 16);;
let () = check "collatz_peak 7 = 52" (collatz_peak 7 = 52);;
let () = check "collatz_peak 27 = 9232" (collatz_peak 27 = 9232);;
let () = check "collatz_peak 0 raises Invalid_argument" (raises_invalid (fun () -> collatz_peak 0));;

let () = check "longest_below 2 = (1, 0)" (longest_below 2 = (1, 0));;
let () = check "longest_below 10 = (9, 19)" (longest_below 10 = (9, 19));;
let () = check "longest_below 100 = (97, 118)" (longest_below 100 = (97, 118));;
let () = check "longest_below 1000 = (871, 178)" (longest_below 1000 = (871, 178));;
let () = check "longest_below 10000 = (6171, 261)" (longest_below 10000 = (6171, 261));;
let () = check "longest_below 1 raises Invalid_argument" (raises_invalid (fun () -> longest_below 1));;
let () = check "THE BIG ONE: longest_below 100000 = (77031, 350)" (longest_below 100000 = (77031, 350));;

let () = summary 28;;
