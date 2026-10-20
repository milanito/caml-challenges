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

(* ===== Exercise 18 · Big Numbers ===== *)

(* most significant digit first: to_string [5; 4; 3; 2; 1] = "12345" *)
let to_string big = String.concat "" (List.rev_map string_of_int big);;

let () = check "big_of_int 0 = [0]" (big_of_int 0 = [0]);;
let () = check "big_of_int 7 = [7]" (big_of_int 7 = [7]);;
let () = check "big_of_int 12345" (big_of_int 12345 = [5; 4; 3; 2; 1]);;
let () = check "big_of_int 1000" (big_of_int 1000 = [0; 0; 0; 1]);;
let () = check "big_of_int (-1) raises Invalid_argument" (raises_invalid (fun () -> big_of_int (-1)));;

let () = check "add_big 999 + 1 = 1000" (to_string (add_big (big_of_int 999) (big_of_int 1)) = "1000");;
let () = check "add_big 12345 + 98765 = 111110" (to_string (add_big (big_of_int 12345) (big_of_int 98765)) = "111110");;
let () = check "add_big 0 + 0 = [0]" (add_big [0] [0] = [0]);;
let () = check "add_big with a much shorter second number"
    (to_string (add_big (big_of_int 123456789) (big_of_int 5)) = "123456794");;
let () = check "add_big with a much shorter first number"
    (to_string (add_big (big_of_int 5) (big_of_int 123456789)) = "123456794");;
let () = check "add_big x + 0 = x" (add_big (big_of_int 4242) [0] = big_of_int 4242);;
let () = check "add_big beyond the 63 bits of an int"
    (to_string (add_big (big_of_int 4611686018427387903) (big_of_int 4611686018427387903)) = "9223372036854775806");;

let () = check "mul_small 999 * 999 = 998001" (to_string (mul_small (big_of_int 999) 999) = "998001");;
let () = check "mul_small 25 * 4 = 100" (to_string (mul_small (big_of_int 25) 4) = "100");;
let () = check "mul_small x * 0 = [0]" (mul_small (big_of_int 12345) 0 = [0]);;
let () = check "mul_small [0] * 7 = [0]" (mul_small [0] 7 = [0]);;
let () = check "mul_small x * 1 = x" (mul_small (big_of_int 12345) 1 = big_of_int 12345);;
let () = check "mul_small 123456789 * 1000" (to_string (mul_small (big_of_int 123456789) 1000) = "123456789000");;
let () = check "mul_small with a big k (carry with several digits)"
    (to_string (mul_small (big_of_int 99) 123456) = "12222144");;
let () = check "mul_small with k < 0 raises Invalid_argument" (raises_invalid (fun () -> mul_small [1] (-1)));;

let () = check "digit_sum [5; 4; 3; 2; 1] = 15" (digit_sum [5; 4; 3; 2; 1] = 15);;
let () = check "digit_sum [0] = 0" (digit_sum [0] = 0);;

let () = check "0! = 1" (to_string (factorial_big 0) = "1");;
let () = check "1! = 1" (to_string (factorial_big 1) = "1");;
let () = check "5! = 120" (to_string (factorial_big 5) = "120");;
let () = check "10! = 3628800" (to_string (factorial_big 10) = "3628800");;
let () = check "20! = 2432902008176640000" (to_string (factorial_big 20) = "2432902008176640000");;
let () = check "25! = 15511210043330985984000000" (to_string (factorial_big 25) = "15511210043330985984000000");;
let () = check "30! = 265252859812191058636308480000000"
    (to_string (factorial_big 30) = "265252859812191058636308480000000");;
let () = check "52! = the number of orders of a deck of cards"
    (to_string (factorial_big 52) = "80658175170943878571660636856403766975289505440883277824000000000000");;
let () = check "100! has 158 digits" (List.length (factorial_big 100) = 158);;
let () = check "the digits of 100! sum to 648" (digit_sum (factorial_big 100) = 648);;
let () = check "1000! has 2568 digits" (List.length (factorial_big 1000) = 2568);;
let () = check "factorial_big (-1) raises Invalid_argument" (raises_invalid (fun () -> factorial_big (-1)));;

let () = check "fib_big 0 = 0" (to_string (fib_big 0) = "0");;
let () = check "fib_big 1 = 1" (to_string (fib_big 1) = "1");;
let () = check "fib_big 10 = 55" (to_string (fib_big 10) = "55");;
let () = check "fib_big 100 = 354224848179261915075" (to_string (fib_big 100) = "354224848179261915075");;
let () = check "fib_big 4781 has 999 digits" (List.length (fib_big 4781) = 999);;
let () = check "fib_big 4782 is the first Fibonacci number with 1000 digits" (List.length (fib_big 4782) = 1000);;
let () = check "fib_big (-1) raises Invalid_argument" (raises_invalid (fun () -> fib_big (-1)));;

let () = check "power_big 2 10 = 1024" (to_string (power_big 2 10) = "1024");;
let () = check "power_big 7 0 = 1" (to_string (power_big 7 0) = "1");;
let () = check "power_big 2 100 = 1267650600228229401496703205376"
    (to_string (power_big 2 100) = "1267650600228229401496703205376");;
let () = check "the digits of 2^1000 sum to 1366" (digit_sum (power_big 2 1000) = 1366);;

let () = summary 45;;
