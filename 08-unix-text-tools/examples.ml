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

(* ===== Exercise 08 · Unix Text Tools ===== *)

let explode s = List.init (String.length s) (String.get s);;
let implode l = String.init (List.length l) (List.nth l);;

let words_of s = List.map implode (words (explode s));;

let () = check "words of a simple sentence" (words_of "the quick brown fox" = ["the"; "quick"; "brown"; "fox"]);;
let () = check "words ignores extra spaces, tabs and newlines"
    (words_of "  the quick   brown\tfox \n" = ["the"; "quick"; "brown"; "fox"]);;
let () = check "words of the empty text" (words [] = []);;
let () = check "words of a text with only spaces" (words (explode " \n\t  ") = []);;
let () = check "words of a single word" (words_of "caml" = ["caml"]);;
let () = check "words keeps punctuation inside words" (words_of "Hello, World!" = ["Hello,"; "World!"]);;

let () = check "uniq removes consecutive duplicates" (uniq [1; 1; 2; 2; 2; 1; 3; 3] = [1; 2; 1; 3]);;
let () = check "uniq []" (uniq ([] : int list) = []);;
let () = check "uniq of a single element" (uniq ['a'] = ['a']);;
let () = check "uniq of identical elements" (uniq [5; 5; 5; 5] = [5]);;
let () = check "uniq keeps non-consecutive duplicates" (uniq [1; 2; 1; 2] = [1; 2; 1; 2]);;
let () = check "sort | uniq: letters of mississippi"
    (implode (uniq (List.sort compare (explode "mississippi"))) = "imps");;

let () = check "wc of the empty text" (wc [] = (0, 0, 0));;
let () = check "wc of two lines" (wc (explode "hello world\nthis is a test\n") = (2, 6, 27));;
let () = check "wc without a final newline" (wc (explode "one two three") = (0, 3, 13));;
let () = check "wc with messy whitespace" (wc (explode "  a \t b\n\n c  ") = (2, 3, 13));;

let () = check "longest_word: the first one wins on a tie"
    (implode (longest_word (explode "the quick brown fox jumps over the lazy dog")) = "quick");;
let () = check "longest_word: a clear winner"
    (implode (longest_word (explode "I love functional programming")) = "programming");;
let () = check "longest_word of a single word" (implode (longest_word (explode "  caml  ")) = "caml");;
let () = check "longest_word without words raises Failure" (raises_failure (fun () -> longest_word (explode "   ")));;

let () = summary 20;;
