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

(* ===== Exercise 04 · Rabbits of Fibonacci ===== *)

(* fib is only tested on small values: the naive version is slow! *)
let () = check "fib 0 = 0" (fib 0 = 0);;
let () = check "fib 1 = 1" (fib 1 = 1);;
let () = check "fib 2 = 1" (fib 2 = 1);;
let () = check "fib 10 = 55" (fib 10 = 55);;
let () = check "fib 20 = 6765" (fib 20 = 6765);;
let () = check "fib (-1) raises Invalid_argument" (raises_invalid (fun () -> fib (-1)));;

let () = check "fib_list 0 = []" (fib_list 0 = []);;
let () = check "fib_list 1 = [0]" (fib_list 1 = [0]);;
let () = check "fib_list 2 = [0; 1]" (fib_list 2 = [0; 1]);;
let () = check "fib_list 10" (fib_list 10 = [0; 1; 1; 2; 3; 5; 8; 13; 21; 34]);;
let () = check "fib_list (-3) raises Invalid_argument" (raises_invalid (fun () -> fib_list (-3)));;

let () = check "fib_fast agrees with fib on 0..20"
    (let rec all i = i > 20 || (fib_fast i = fib i && all (i + 1)) in all 0);;
let () = check "fib_fast 30 = 832040" (fib_fast 30 = 832040);;
let () = check "fib_fast 80 = 23416728348467685" (fib_fast 80 = 23416728348467685);;
let () = check "fib_fast 90 = 2880067194370816120" (fib_fast 90 = 2880067194370816120);;
let () = check "fib_fast (-1) raises Invalid_argument" (raises_invalid (fun () -> fib_fast (-1)));;

let () = check "sum_even_fibs 10 = 10" (sum_even_fibs 10 = 10);;
let () = check "sum_even_fibs 100 = 44" (sum_even_fibs 100 = 44);;
let () = check "sum_even_fibs 1 = 0" (sum_even_fibs 1 = 0);;
let () = check "sum_even_fibs 4_000_000 = 4613732" (sum_even_fibs 4_000_000 = 4613732);;

let () = summary 20;;
