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

(* ===== Exercise 02 · Hopper's Bug ===== *)

let log_book = ["start"; "test"; "bug"; "test"; "bug"; "done"];;

let () = check "mem finds a string" (mem "bug" log_book);;
let () = check "mem does not find a missing string" (not (mem "moth" log_book));;
let () = check "mem on the empty list" (not (mem 1 []));;
let () = check "mem works on chars too" (mem 'c' ['a'; 'b'; 'c']);;

let () = check "index_of first element is 1" (index_of "start" log_book = 1);;
let () = check "index_of returns the FIRST occurrence" (index_of "bug" log_book = 3);;
let () = check "index_of last element" (index_of "done" log_book = 6);;
let () = check "index_of on ints" (index_of 42 [7; 42; 42] = 2);;
let () = check "index_of missing raises Failure" (raises_failure (fun () -> index_of "moth" log_book));;
let () = check "index_of on [] raises Failure" (raises_failure (fun () -> index_of 1 []));;

let () = check "positions of all the bugs" (positions "bug" log_book = [3; 5]);;
let () = check "positions of an element appearing once" (positions "done" log_book = [6]);;
let () = check "positions of a missing element" (positions "moth" log_book = []);;
let () = check "positions when everything matches" (positions 0 [0; 0; 0] = [1; 2; 3]);;

let () = check "remove_first removes only the first" (remove_first "bug" log_book = ["start"; "test"; "test"; "bug"; "done"]);;
let () = check "remove_first of a missing element" (remove_first "moth" log_book = log_book);;
let () = check "remove_first on []" (remove_first 3 [] = []);;
let () = check "remove_first on ints" (remove_first 1 [2; 1; 3; 1] = [2; 3; 1]);;

let () = check "squash removes all the bugs" (squash "bug" log_book = ["start"; "test"; "test"; "done"]);;
let () = check "squash everything" (squash 1 [1; 1; 1] = []);;
let () = check "squash a missing element" (squash 9 [1; 2; 3] = [1; 2; 3]);;
let () = check "squash keeps the order" (squash 'a' ['b'; 'a'; 'c'; 'a'; 'd'] = ['b'; 'c'; 'd']);;

let () = summary 22;;
