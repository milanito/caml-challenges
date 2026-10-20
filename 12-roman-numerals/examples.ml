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

(* ===== Exercise 12 · Roman Numerals ===== *)

let explode s = List.init (String.length s) (String.get s);;
let implode l = String.init (List.length l) (List.nth l);;

let roman n = implode (roman_of_int n);;
let value s = int_of_roman (explode s);;

let () = check "1 = I" (roman 1 = "I");;
let () = check "4 = IV" (roman 4 = "IV");;
let () = check "9 = IX" (roman 9 = "IX");;
let () = check "14 = XIV" (roman 14 = "XIV");;
let () = check "40 = XL" (roman 40 = "XL");;
let () = check "49 = XLIX" (roman 49 = "XLIX");;
let () = check "58 = LVIII" (roman 58 = "LVIII");;
let () = check "90 = XC" (roman 90 = "XC");;
let () = check "400 = CD" (roman 400 = "CD");;
let () = check "444 = CDXLIV" (roman 444 = "CDXLIV");;
let () = check "1987 = MCMLXXXVII" (roman 1987 = "MCMLXXXVII");;
let () = check "1994 = MCMXCIV" (roman 1994 = "MCMXCIV");;
let () = check "2026 = MMXXVI" (roman 2026 = "MMXXVI");;
let () = check "3888 = MMMDCCCLXXXVIII" (roman 3888 = "MMMDCCCLXXXVIII");;
let () = check "3999 = MMMCMXCIX" (roman 3999 = "MMMCMXCIX");;
let () = check "roman_of_int 0 raises Invalid_argument" (raises_invalid (fun () -> roman_of_int 0));;
let () = check "roman_of_int 4000 raises Invalid_argument" (raises_invalid (fun () -> roman_of_int 4000));;
let () = check "roman_of_int (-7) raises Invalid_argument" (raises_invalid (fun () -> roman_of_int (-7)));;

let () = check "I = 1" (value "I" = 1);;
let () = check "IV = 4" (value "IV" = 4);;
let () = check "XLII = 42" (value "XLII" = 42);;
let () = check "MCMXCIV = 1994" (value "MCMXCIV" = 1994);;
let () = check "MMXXVI = 2026" (value "MMXXVI" = 2026);;
let () = check "MMMCMXCIX = 3999" (value "MMMCMXCIX" = 3999);;
let () = check "an invalid character raises Failure" (raises_failure (fun () -> value "XIZ"));;

let () = check "int_of_roman (roman_of_int n) = n for EVERY n from 1 to 3999"
    (let rec all n = n > 3999 || (int_of_roman (roman_of_int n) = n && all (n + 1)) in all 1);;

let () = check "add_roman XIV + XXVIII = XLII"
    (implode (add_roman (explode "XIV") (explode "XXVIII")) = "XLII");;
let () = check "add_roman MCMXCIV + XXXII = MMXXVI"
    (implode (add_roman (explode "MCMXCIV") (explode "XXXII")) = "MMXXVI");;
let () = check "add_roman I + I = II" (implode (add_roman (explode "I") (explode "I")) = "II");;
let () = check "add_roman gives the canonical numeral (IV + IV = VIII)"
    (implode (add_roman (explode "IV") (explode "IV")) = "VIII");;
let () = check "add_roman above 3999 raises Invalid_argument"
    (raises_invalid (fun () -> add_roman (explode "MMM") (explode "MM")));;

let () = check "longest_roman () is 3888" (longest_roman () = 3888);;

let () = summary 32;;
