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

(* ===== Exercise 06 · Caesar's Secret ===== *)

(* string <-> char list conversions (only for the tests and for you to play with) *)
let explode s = List.init (String.length s) (String.get s);;
let implode l = String.init (List.length l) (List.nth l);;

(* the secret message: which key was used? *)
let mystery = "Tlla tl ha aol vsk jsvjr avdly ha tpkupnoa, huk iypun aol thw!";;

(* prints the 26 possible decryptions of a text *)
let brute_force text =
  for k = 0 to 25 do
    Printf.printf "%2d: %s\n" k (implode (decrypt k (explode text)))
  done;;

let () = check "shift_char 3 'a' = 'd'" (shift_char 3 'a' = 'd');;
let () = check "shift_char 3 'z' wraps around to 'c'" (shift_char 3 'z' = 'c');;
let () = check "shift_char 3 'y' = 'b'" (shift_char 3 'y' = 'b');;
let () = check "uppercase stays uppercase" (shift_char 3 'Z' = 'C');;
let () = check "negative key" (shift_char (-3) 'a' = 'x');;
let () = check "negative key on uppercase" (shift_char (-1) 'A' = 'Z');;
let () = check "key 26 changes nothing" (shift_char 26 'q' = 'q');;
let () = check "key 29 = key 3" (shift_char 29 'a' = 'd');;
let () = check "key 0 changes nothing" (shift_char 0 'm' = 'm');;
let () = check "a space is unchanged" (shift_char 3 ' ' = ' ');;
let () = check "a digit is unchanged" (shift_char 3 '5' = '5');;
let () = check "punctuation is unchanged" (shift_char 3 '!' = '!');;

let () = check "encrypt 3 \"Hello, World!\""
    (implode (encrypt 3 (explode "Hello, World!")) = "Khoor, Zruog!");;
let () = check "encrypt the empty text" (encrypt 5 [] = []);;
let () = check "decrypt 3 \"Khoor, Zruog!\""
    (implode (decrypt 3 (explode "Khoor, Zruog!")) = "Hello, World!");;
let () = check "decrypt undoes encrypt, for every key from 0 to 25"
    (let msg = explode "The Quick Brown Fox Jumps Over The Lazy Dog, 42 times!" in
     let rec all k = k > 25 || (decrypt k (encrypt k msg) = msg && all (k + 1)) in
     all 0);;
let () = check "encrypt with a key of 26 changes nothing"
    (implode (encrypt 26 (explode "Same Text")) = "Same Text");;

let () = check "rot13 \"Hello, World!\""
    (implode (rot13 (explode "Hello, World!")) = "Uryyb, Jbeyq!");;
let () = check "rot13 applied twice is the identity"
    (let t = explode "Why did the chicken cross the road?" in rot13 (rot13 t) = t);;

let () = check "secret_shift is the right key"
    (let k = ((secret_shift mod 26) + 26) mod 26 in (k * 5 + 3) mod 26 = 12);;

let () = summary 20;;

let () = print_endline "\nMystery time! Once everything above is OK, type:   brute_force mystery;;";;
