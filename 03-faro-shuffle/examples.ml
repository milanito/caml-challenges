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

(* ===== Exercise 03 · The Faro Shuffle ===== *)

(* make_deck n = [1; 2; ...; n] *)
let rec make_deck n = if n <= 0 then [] else make_deck (n - 1) @ [n];;

let () = check "take 2" (take 2 [1; 2; 3; 4; 5] = [1; 2]);;
let () = check "take 0" (take 0 [1; 2; 3] = []);;
let () = check "take a negative number" (take (-3) [1; 2; 3] = []);;
let () = check "take more than the length" (take 10 [1; 2; 3] = [1; 2; 3]);;
let () = check "take on []" (take 3 [] = []);;

let () = check "drop 2" (drop 2 [1; 2; 3; 4; 5] = [3; 4; 5]);;
let () = check "drop 0" (drop 0 [1; 2; 3] = [1; 2; 3]);;
let () = check "drop a negative number" (drop (-1) [1; 2; 3] = [1; 2; 3]);;
let () = check "drop more than the length" (drop 99 [1; 2; 3] = []);;

let () = check "split_at 2" (split_at 2 [1; 2; 3; 4; 5] = ([1; 2], [3; 4; 5]));;
let () = check "split_at 0" (split_at 0 ['a'; 'b'] = ([], ['a'; 'b']));;

let () = check "cut 2" (cut 2 [1; 2; 3; 4; 5] = [3; 4; 5; 1; 2]);;
let () = check "cut 0 changes nothing" (cut 0 [1; 2; 3] = [1; 2; 3]);;
let () = check "cut the whole deck changes nothing" (cut 3 [1; 2; 3] = [1; 2; 3]);;

let () = check "riffle of equal lengths" (riffle [1; 3; 5] [2; 4; 6] = [1; 2; 3; 4; 5; 6]);;
let () = check "riffle: first list shorter" (riffle [1] [2; 3; 4] = [1; 2; 3; 4]);;
let () = check "riffle: second list shorter" (riffle [1; 2; 3] [9] = [1; 9; 2; 3]);;
let () = check "riffle with an empty list" (riffle [1; 2; 3] [] = [1; 2; 3]);;
let () = check "riffle [] []" (riffle [] [] = ([] : int list));;

let () = check "faro on 6 cards" (faro [1; 2; 3; 4; 5; 6] = [1; 4; 2; 5; 3; 6]);;
let () = check "faro on 4 cards" (faro ['a'; 'b'; 'c'; 'd'] = ['a'; 'c'; 'b'; 'd']);;
let () = check "faro on the empty deck" (faro [] = ([] : int list));;
let () = check "faro on an odd deck raises Invalid_argument" (raises_invalid (fun () -> faro [1; 2; 3]));;

let () = check "faro_period of 2 cards is 1" (faro_period [1; 2] = 1);;
let () = check "faro_period of 4 cards is 2" (faro_period (make_deck 4) = 2);;
let () = check "faro_period of 8 cards is 3" (faro_period (make_deck 8) = 3);;
let () = check "faro_period of 10 cards is 6" (faro_period (make_deck 10) = 6);;
let () = check "faro_period of 52 cards is 8 !!!" (faro_period (make_deck 52) = 8);;

let () = summary 28;;
