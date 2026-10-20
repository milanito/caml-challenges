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

(* ===== Exercise 05 · Babbage's Engine ===== *)

(* Euler's polynomial *)
let poly n = n * n + n + 41;;

(* a simple primality test, only used by the tests *)
let is_prime_h n =
  n >= 2 && (let rec go d = d * d > n || (n mod d <> 0 && go (d + 1)) in go 2);;

let () = check "twice squares twice" (twice (fun x -> x * x) 3 = 81);;
let () = check "twice on strings" (twice (fun s -> s ^ "!") "hey" = "hey!!");;
let () = check "twice with a named function" (twice succ 10 = 12);;

let () = check "compose: f after g" (compose (fun x -> x + 1) (fun x -> x * 2) 5 = 11);;
let () = check "compose is not commutative" (compose (fun x -> x * 2) (fun x -> x + 1) 5 = 12);;
let () = check "compose changes types" (compose String.length string_of_int 12345 = 5);;
let () = check "compose can be partially applied" ((compose succ succ) 0 = 2);;

let () = check "iterate 10 doublings" (iterate (fun x -> 2 * x) 10 1 = 1024);;
let () = check "iterate 0 times = identity" (iterate succ 0 5 = 5);;
let () = check "iterate on strings" (iterate (fun s -> s ^ "!") 3 "hey" = "hey!!!");;
let () = check "iterate with n < 0 raises Invalid_argument" (raises_invalid (fun () -> iterate succ (-1) 0));;

let () = check "tabulate poly 7" (tabulate poly 7 = [41; 43; 47; 53; 61; 71; 83]);;
let () = check "tabulate 0 = []" (tabulate poly 0 = []);;
let () = check "tabulate squares" (tabulate (fun i -> i * i) 5 = [0; 1; 4; 9; 16]);;
let () = check "tabulate can build strings" (tabulate string_of_int 3 = ["0"; "1"; "2"]);;
let () = check "tabulate with n < 0 raises Invalid_argument" (raises_invalid (fun () -> tabulate poly (-1)));;

let () = check "differences [41; 43; 47; 53]" (differences [41; 43; 47; 53] = [2; 4; 6]);;
let () = check "differences []" (differences [] = []);;
let () = check "differences [7]" (differences [7] = []);;
let () = check "differences of a decreasing list" (differences [10; 7; 3] = [-3; -4]);;

let () = check "Babbage: second differences of n^2+n+41 are constant"
    (iterate differences 2 (tabulate poly 7) = [2; 2; 2; 2; 2]);;
let () = check "third differences of n^3 are constant"
    (iterate differences 3 (tabulate (fun n -> n * n * n) 8) = [6; 6; 6; 6; 6]);;
let () = check "Euler: n^2+n+41 is prime for n = 0..39"
    (let rec all = function [] -> true | e :: l -> is_prime_h e && all l in all (tabulate poly 40));;
let () = check "...but not for n = 40 (it is 41 * 41)"
    (not (is_prime_h (poly 40)));;

let () = check "brain teaser: twice twice (fun x -> x + 1) 0 = 4"
    (twice twice (fun x -> x + 1) 0 = 4);;

let () = summary 25;;
