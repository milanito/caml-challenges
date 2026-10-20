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

(* ===== Exercise 09 · Pascal's Triangle ===== *)

let () = check "next_row [1]" (next_row [1] = [1; 1]);;
let () = check "next_row [1; 1]" (next_row [1; 1] = [1; 2; 1]);;
let () = check "next_row [1; 3; 3; 1]" (next_row [1; 3; 3; 1] = [1; 4; 6; 4; 1]);;
let () = check "next_row [1; 5; 10; 10; 5; 1]" (next_row [1; 5; 10; 10; 5; 1] = [1; 6; 15; 20; 15; 6; 1]);;
let () = check "next_row [] raises Invalid_argument" (raises_invalid (fun () -> next_row []));;

let () = check "pascal 0 = []" (pascal 0 = []);;
let () = check "pascal 1" (pascal 1 = [[1]]);;
let () = check "pascal 5" (pascal 5 = [[1]; [1; 1]; [1; 2; 1]; [1; 3; 3; 1]; [1; 4; 6; 4; 1]]);;
let () = check "pascal 12: the row number 11"
    (List.nth (pascal 12) 11 = [1; 11; 55; 165; 330; 462; 462; 330; 165; 55; 11; 1]);;
let () = check "pascal: the sum of row n is 2^n"
    (let rows = pascal 15 in
     let rec ok i = i >= 15 || (List.fold_left (+) 0 (List.nth rows i) = 1 lsl i && ok (i + 1)) in
     ok 0);;
let () = check "pascal (-1) raises Invalid_argument" (raises_invalid (fun () -> pascal (-1)));;

let () = check "binomial 5 2 = 10" (binomial 5 2 = 10);;
let () = check "binomial 10 3 = 120" (binomial 10 3 = 120);;
let () = check "binomial n 0 = 1" (binomial 7 0 = 1);;
let () = check "binomial n n = 1" (binomial 7 7 = 1);;
let () = check "binomial 20 10 = 184756" (binomial 20 10 = 184756);;
let () = check "binomial 30 15 = 155117520" (binomial 30 15 = 155117520);;
let () = check "binomial 3 5 raises Invalid_argument" (raises_invalid (fun () -> binomial 3 5));;
let () = check "binomial 4 (-1) raises Invalid_argument" (raises_invalid (fun () -> binomial 4 (-1)));;
let () = check "binomial (-1) 0 raises Invalid_argument" (raises_invalid (fun () -> binomial (-1) 0));;

let () = summary 20;;

(* ===== The surprise: odd numbers of Pascal's triangle draw a fractal ===== *)
let print_sierpinski n =
  List.iteri
    (fun i row ->
       print_string (String.make (n - 1 - i) ' ');
       List.iter (fun x -> print_string (if x mod 2 = 1 then "* " else "  ")) row;
       print_newline ())
    (pascal n);;

let () = print_endline "\nOdd entries of Pascal's triangle (16 rows):\n";;
let () = print_sierpinski 16;;
