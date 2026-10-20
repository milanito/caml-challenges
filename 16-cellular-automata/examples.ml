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

(* ===== Exercise 16 · Cellular Automata ===== *)

(* a row of cells as a string: '#' alive, '.' dead *)
let show cells = String.concat "" (List.map (fun b -> if b then "#" else ".") cells);;

(* a row with a single living cell at the far right *)
let right_cell w = List.init w (fun i -> i = w - 1);;

let () = check "rule_bit 90 0 = false" (rule_bit 90 0 = false);;
let () = check "rule_bit 90 1 = true" (rule_bit 90 1 = true);;
let () = check "rule_bit 90 2 = false" (rule_bit 90 2 = false);;
let () = check "rule_bit 90 3 = true" (rule_bit 90 3 = true);;
let () = check "rule_bit 90 4 = true" (rule_bit 90 4 = true);;
let () = check "rule_bit 90 6 = true" (rule_bit 90 6 = true);;
let () = check "rule_bit 90 7 = false" (rule_bit 90 7 = false);;
let () = check "rule_bit 30 1 = true and rule_bit 30 5 = false" (rule_bit 30 1 && not (rule_bit 30 5));;
let () = check "rule_bit 110 4 = false and rule_bit 110 5 = true" (not (rule_bit 110 4) && rule_bit 110 5);;
let () = check "rule_bit 255 7 = true" (rule_bit 255 7);;
let () = check "rule_bit 0 7 = false" (not (rule_bit 0 7));;
let () = check "rule_bit 256 0 raises Invalid_argument" (raises_invalid (fun () -> rule_bit 256 0));;
let () = check "rule_bit 90 8 raises Invalid_argument" (raises_invalid (fun () -> rule_bit 90 8));;
let () = check "rule_bit (-1) 0 raises Invalid_argument" (raises_invalid (fun () -> rule_bit (-1) 0));;

let () = check "single_cell 7" (show (single_cell 7) = "...#...");;
let () = check "single_cell 8" (show (single_cell 8) = "....#...");;
let () = check "single_cell 1" (show (single_cell 1) = "#");;
let () = check "single_cell 0 raises Invalid_argument" (raises_invalid (fun () -> single_cell 0));;

let () = check "step 90 on a single cell" (show (step 90 (single_cell 7)) = "..#.#..");;
let () = check "step 30 on a single cell" (show (step 30 (single_cell 7)) = "..###..");;
let () = check "step 0 kills everything" (show (step 0 (single_cell 7)) = ".......");;
let () = check "step 255 brings everything to life" (show (step 255 (single_cell 7)) = "#######");;
let () = check "step keeps the length of the row" (List.length (step 110 (single_cell 25)) = 25);;
let () = check "step on the empty row" (step 90 [] = []);;
let () = check "step 110 from the right edge" (show (step 110 (right_cell 8)) = "......##");;

let () = check "run 90 for 3 ticks"
    (List.map show (run 90 3 (single_cell 7)) = ["...#..."; "..#.#.."; ".#...#."; "#.#.#.#"]);;
let () = check "run 30 for 3 ticks"
    (List.map show (run 30 3 (single_cell 7)) = ["...#..."; "..###.."; ".##..#."; "##.####"]);;
let () = check "run 110 for 3 ticks, from the right edge"
    (List.map show (run 110 3 (right_cell 8)) = [".......#"; "......##"; ".....###"; "....##.#"]);;
let () = check "run 0 ticks gives just the initial row" (run 90 0 (single_cell 5) = [single_cell 5]);;
let () = check "run with n < 0 raises Invalid_argument" (raises_invalid (fun () -> run 90 (-1) (single_cell 5)));;
let () = check "run gives n + 1 rows" (List.length (run 30 20 (single_cell 41)) = 21);;

let () = check "populations of rule 90: powers of 2!"
    (populations 90 31 7 = [1; 2; 2; 4; 2; 4; 4; 8]);;
let () = check "populations of rule 30" (populations 30 31 7 = [1; 3; 3; 6; 4; 9; 5; 12]);;
let () = check "populations of rule 110" (populations 110 31 5 = [1; 2; 3; 3; 5; 3]);;
let () = check "populations of rule 0" (populations 0 7 3 = [1; 0; 0; 0]);;

let () = summary 35;;

(* ===== The show: draw an automaton with YOUR run ===== *)
let animate rule width n_ticks =
  Printf.printf "\nRule %d\n" rule;
  List.iter (fun row -> print_endline (show row)) (run rule n_ticks (single_cell width));;

let () = animate 90 31 15;;
let () = animate 30 31 15;;
let () =
  print_endline "\nRule 110 (starting from the right edge)";
  List.iter (fun row -> print_endline (show row)) (run 110 20 (right_cell 41));;
