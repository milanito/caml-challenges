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

(* ===== Exercise 10 · Merge Sort ===== *)

(* n pseudo-random numbers (linear congruential generator, only used by the tests) *)
let rec lcg n seed =
  if n = 0 then []
  else
    let s = (seed * 1103515245 + 12345) mod 2147483648 in
    s :: lcg (n - 1) s;;

let rec is_sorted_h ord = function
  | a :: (b :: _ as rest) -> ord a b && is_sorted_h ord rest
  | _ -> true;;

let () = check "merge (<=) of two sorted lists" (merge (<=) [1; 4; 9] [2; 3; 10] = [1; 2; 3; 4; 9; 10]);;
let () = check "merge with an empty first list" (merge (<=) [] [1; 2] = [1; 2]);;
let () = check "merge with an empty second list" (merge (<=) [1; 2] [] = [1; 2]);;
let () = check "merge [] []" (merge (<=) [] ([] : int list) = []);;
let () = check "merge lists that do not overlap" (merge (<=) [1; 2; 3] [4; 5; 6] = [1; 2; 3; 4; 5; 6]);;
let () = check "merge lists that do not overlap (reversed roles)" (merge (<=) [4; 5; 6] [1; 2; 3] = [1; 2; 3; 4; 5; 6]);;
let () = check "merge keeps duplicates" (merge (<=) [1; 2; 2] [2; 3] = [1; 2; 2; 2; 3]);;
let () = check "merge in decreasing order" (merge (>=) [9; 4; 1] [10; 3; 2] = [10; 9; 4; 3; 2; 1]);;
let () = check "merge with a strict order on distinct values" (merge (<) [1; 3] [2; 4] = [1; 2; 3; 4]);;
let () = check "merge works on strings" (merge (<=) ["a"; "c"] ["b"; "d"] = ["a"; "b"; "c"; "d"]);;

let () = check "halve []" (halve ([] : int list) = ([], []));;
let () = check "halve [1]" (halve [1] = ([1], []));;
let () = check "halve [1; 2]" (halve [1; 2] = ([1], [2]));;
let () = check "halve [1; 2; 3; 4; 5]" (halve [1; 2; 3; 4; 5] = ([1; 3; 5], [2; 4]));;
let () = check "halve [1; 2; 3; 4; 5; 6]" (halve [1; 2; 3; 4; 5; 6] = ([1; 3; 5], [2; 4; 6]));;

let () = check "merge_sort []" (merge_sort (<=) ([] : int list) = []);;
let () = check "merge_sort [42]" (merge_sort (<=) [42] = [42]);;
let () = check "merge_sort of 5 numbers" (merge_sort (<=) [5; 3; 8; 1; 4] = [1; 3; 4; 5; 8]);;
let () = check "merge_sort decreasing" (merge_sort (>=) [10; 20; 15; 5; 30] = [30; 20; 15; 10; 5]);;
let () = check "merge_sort with duplicates" (merge_sort (<=) [3; 1; 3; 2; 1; 3] = [1; 1; 2; 3; 3; 3]);;
let () = check "merge_sort of an already sorted list" (merge_sort (<=) [1; 2; 3; 4; 5; 6] = [1; 2; 3; 4; 5; 6]);;
let () = check "merge_sort of a reversed list" (merge_sort (<=) [6; 5; 4; 3; 2; 1] = [1; 2; 3; 4; 5; 6]);;
let () = check "merge_sort on chars" (merge_sort (<=) ['d'; 'a'; 'c'; 'b'; 'e'] = ['a'; 'b'; 'c'; 'd'; 'e']);;
let () = check "merge_sort on floats" (merge_sort (<=) [1.1; 3.3; 2.2; 5.5; 4.4] = [1.1; 2.2; 3.3; 4.4; 5.5]);;
let () = check "merge_sort with a custom order (by string length)"
    (merge_sort (fun a b -> String.length a <= String.length b) ["ccc"; "a"; ""; "dddd"; "bb"]
     = [""; "a"; "bb"; "ccc"; "dddd"]);;
let () = check "merge_sort sorts 50 000 random numbers like List.sort does"
    (let big = lcg 50000 42 in merge_sort (<=) big = List.sort compare big);;
let () = check "merge_sort result is sorted (50 000 numbers, decreasing)"
    (is_sorted_h (>=) (merge_sort (>=) (lcg 50000 7)));;

let () = summary 27;;
