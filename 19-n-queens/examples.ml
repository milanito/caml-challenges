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

(* ===== Exercise 19 · The N-Queens Puzzle ===== *)

(* independent checker: is sol a valid placement of n queens? (does not use YOUR safe) *)
let valid_solution n sol =
  let arr = Array.of_list sol in
  let ok = ref (Array.length arr = n) in
  if !ok then
    for i = 0 to n - 1 do
      if arr.(i) < 1 || arr.(i) > n then ok := false;
      for j = i + 1 to n - 1 do
        if arr.(i) = arr.(j) || abs (arr.(i) - arr.(j)) = j - i then ok := false
      done
    done;
  !ok;;

(* are all the solutions of the n-queens problem present, valid, and different? *)
let all_good n expected_count =
  let sols = queens n in
  List.length sols = expected_count
  && List.for_all (valid_solution n) sols
  && List.length (List.sort_uniq compare sols) = expected_count;;

let () = check "safe on an empty board" (safe 1 [] = true);;
let () = check "safe: same column is not safe" (safe 1 [1] = false);;
let () = check "safe: diagonal just above (right)" (safe 2 [1] = false);;
let () = check "safe: diagonal just above (left)" (safe 1 [2] = false);;
let () = check "safe: a knight's move away is safe" (safe 3 [1] = true);;
let () = check "safe: same column two rows above" (safe 4 [2; 4] = false);;
let () = check "safe: diagonal two rows above" (safe 3 [5; 1] = false);;
let () = check "safe: nothing attacks" (safe 5 [3; 1] = true);;

let () = check "queens 1 = [[1]]" (queens 1 = [[1]]);;
let () = check "queens 2 has no solution" (queens 2 = []);;
let () = check "queens 3 has no solution" (queens 3 = []);;
let () = check "queens 4: the two solutions"
    (List.sort compare (queens 4) = [[2; 4; 1; 3]; [3; 1; 4; 2]]);;
let () = check "queens 5: 10 valid and different solutions" (all_good 5 10);;
let () = check "queens 6: 4 valid and different solutions" (all_good 6 4);;
let () = check "queens 7: 40 valid and different solutions" (all_good 7 40);;
let () = check "queens 8: 92 valid and different solutions" (all_good 8 92);;
let () = check "queens 0 raises Invalid_argument" (raises_invalid (fun () -> queens 0));;

let () = check "count_queens 6 = 4" (count_queens 6 = 4);;
let () = check "count_queens 8 = 92" (count_queens 8 = 92);;
let () = check "count_queens 9 = 352" (count_queens 9 = 352);;
let () = check "count_queens 10 = 724 (be patient)" (count_queens 10 = 724);;

let () = summary 21;;

(* ===== The board: the first solution of the 8-queens problem found by YOUR queens ===== *)
let show_board n sol =
  List.iter
    (fun c ->
       print_endline (String.concat "" (List.init n (fun i -> if i + 1 = c then "Q " else ". "))))
    sol;;

let () =
  match queens 8 with
  | first :: _ -> print_endline "\nOne solution to the 8-queens problem:\n"; show_board 8 first
  | [] -> print_endline "\n(no solution found for 8 queens yet)";;
