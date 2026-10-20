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

(* ===== Exercise 13 · Sieve & Goldbach ===== *)

let () = check "sieve of 2..20" (sieve (range 2 20) = [2; 3; 5; 7; 11; 13; 17; 19]);;
let () = check "sieve []" (sieve [] = []);;
let () = check "sieve [2]" (sieve [2] = [2]);;

let () = check "primes_upto 1 = []" (primes_upto 1 = []);;
let () = check "primes_upto 2 = [2]" (primes_upto 2 = [2]);;
let () = check "primes_upto 30" (primes_upto 30 = [2; 3; 5; 7; 11; 13; 17; 19; 23; 29]);;
let () = check "primes_upto 50"
    (primes_upto 50 = [2; 3; 5; 7; 11; 13; 17; 19; 23; 29; 31; 37; 41; 43; 47]);;
let () = check "25 primes below 100" (List.length (primes_upto 100) = 25);;
let () = check "168 primes below 1000" (List.length (primes_upto 1000) = 168);;
let () = check "1229 primes below 10 000" (List.length (primes_upto 10000) = 1229);;

let () = check "goldbach 4 = (2, 2)" (goldbach 4 = (2, 2));;
let () = check "goldbach 10 = (3, 7)" (goldbach 10 = (3, 7));;
let () = check "goldbach 28 = (5, 23)" (goldbach 28 = (5, 23));;
let () = check "goldbach 98 = (19, 79)" (goldbach 98 = (19, 79));;
let () = check "goldbach 100 = (3, 97)" (goldbach 100 = (3, 97));;
let () = check "goldbach 1000 = (3, 997)" (goldbach 1000 = (3, 997));;
let () = check "goldbach of an odd number raises Invalid_argument" (raises_invalid (fun () -> goldbach 9));;
let () = check "goldbach 2 raises Invalid_argument" (raises_invalid (fun () -> goldbach 2));;
let () = check "goldbach holds for every even number from 4 to 1000"
    (let rec all n =
       n > 1000 || (let (p, q) = goldbach n in p + q = n && all (n + 2)) in
     all 4);;

let () = check "count_goldbach 4 = 1" (count_goldbach 4 = 1);;
let () = check "count_goldbach 10 = 2" (count_goldbach 10 = 2);;
let () = check "count_goldbach 28 = 2" (count_goldbach 28 = 2);;
let () = check "count_goldbach 100 = 6" (count_goldbach 100 = 6);;
let () = check "count_goldbach of an odd number raises Invalid_argument" (raises_invalid (fun () -> count_goldbach 7));;

let () = check "twin_primes 3 = []" (twin_primes 3 = []);;
let () = check "twin_primes 7" (twin_primes 7 = [(3, 5); (5, 7)]);;
let () = check "twin_primes 20" (twin_primes 20 = [(3, 5); (5, 7); (11, 13); (17, 19)]);;
let () = check "twin_primes 100"
    (twin_primes 100 = [(3, 5); (5, 7); (11, 13); (17, 19); (29, 31); (41, 43); (59, 61); (71, 73)]);;

let () = summary 28;;
