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

(* ===== Exercise 01 · Ada's Notes ===== *)

let () = check "sum [] = 0" (sum [] = 0);;
let () = check "sum [1; 2; 3; 4] = 10" (sum [1; 2; 3; 4] = 10);;
let () = check "sum with negative numbers" (sum [-5; 5; -10] = -10);;

let () = check "length [] = 0" (length [] = 0);;
let () = check "length of an int list" (length [4; 8; 15; 16; 23; 42] = 6);;
let () = check "length of a string list" (length ["a"; "b"] = 2);;

let () = check "last [1; 2; 3] = 3" (last [1; 2; 3] = 3);;
let () = check "last of a one-element list" (last ['x'] = 'x');;
let () = check "last [] raises Failure" (raises_failure (fun () -> last []));;

let () = check "average [10; 20; 30] = 20" (average [10; 20; 30] = 20);;
let () = check "average rounds down" (average [1; 2] = 1);;
let () = check "average [] raises Invalid_argument" (raises_invalid (fun () -> average []));;

let () = check "range 1 5" (range 1 5 = [1; 2; 3; 4; 5]);;
let () = check "range 3 3 = [3]" (range 3 3 = [3]);;
let () = check "range 5 1 = []" (range 5 1 = []);;
let () = check "range with negative start" (range (-2) 2 = [-2; -1; 0; 1; 2]);;
let () = check "Gauss: sum (range 1 100) = 5050" (sum (range 1 100) = 5050);;

let () = summary 17;;
