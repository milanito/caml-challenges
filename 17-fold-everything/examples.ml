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

(* ===== Exercise 17 · Fold Everything ===== *)

let rec upto a b = if a > b then [] else a :: upto (a + 1) b;;
let even x = x mod 2 = 0;;

let () = check "length []" (length [] = 0);;
let () = check "length [1; 2; 3]" (length [1; 2; 3] = 3);;
let () = check "length of strings" (length ["a"; "b"] = 2);;

let () = check "sum []" (sum [] = 0);;
let () = check "sum [1; 2; 3; 4]" (sum [1; 2; 3; 4] = 10);;

let () = check "rev []" (rev ([] : int list) = []);;
let () = check "rev [1; 2; 3]" (rev [1; 2; 3] = [3; 2; 1]);;
let () = check "rev on chars" (rev ['a'; 'b'] = ['b'; 'a']);;

let () = check "map (fun x -> x * 2)" (map (fun x -> x * 2) [1; 2; 3] = [2; 4; 6]);;
let () = check "map changes the type" (map string_of_int [1; 2; 3] = ["1"; "2"; "3"]);;
let () = check "map keeps the order" (map (fun x -> x) [5; 3; 9] = [5; 3; 9]);;
let () = check "map []" (map succ [] = []);;

let () = check "filter even" (filter even [1; 2; 3; 4; 5; 6] = [2; 4; 6]);;
let () = check "filter nothing" (filter (fun _ -> false) [1; 2; 3] = []);;
let () = check "filter everything" (filter (fun _ -> true) [1; 2; 3] = [1; 2; 3]);;

let () = check "append" (append [1; 2] [3; 4; 5] = [1; 2; 3; 4; 5]);;
let () = check "append [] l" (append [] [1; 2] = [1; 2]);;
let () = check "append l []" (append [1; 2] [] = [1; 2]);;

let () = check "flatten" (flatten [[1]; [2; 3]; []; [4]] = [1; 2; 3; 4]);;
let () = check "flatten []" (flatten ([] : int list list) = []);;

let () = check "max_elt on ints" (max_elt [3; 9; 2] = 9);;
let () = check "max_elt on strings" (max_elt ["b"; "z"; "a"] = "z");;
let () = check "max_elt of a single element" (max_elt [7] = 7);;
let () = check "max_elt [] raises Failure" (raises_failure (fun () -> max_elt ([] : int list)));;

let () = check "partition even" (partition even [1; 2; 3; 4; 5] = ([2; 4], [1; 3; 5]));;
let () = check "partition []" (partition even [] = ([], []));;
let () = check "partition: everything on one side" (partition even [2; 4] = ([2; 4], []));;
let () = check "partition keeps the original order" (partition (fun x -> x > 3) [5; 1; 4; 2; 6; 3] = ([5; 4; 6], [1; 2; 3]));;

let () = check "for_all true" (for_all even [2; 4; 6] = true);;
let () = check "for_all false" (for_all even [2; 3; 6] = false);;
let () = check "for_all [] = true" (for_all even [] = true);;

let () = check "unzip" (unzip [(1, 'a'); (2, 'b'); (3, 'c')] = ([1; 2; 3], ['a'; 'b'; 'c']));;
let () = check "unzip []" (unzip ([] : (int * int) list) = ([], []));;

let () = check "my_fold_left (-)" (my_fold_left (-) 10 [1; 2; 3] = 4);;
let () = check "my_fold_left builds a reversed list" (my_fold_left (fun acc e -> e :: acc) [] [1; 2; 3] = [3; 2; 1]);;
let () = check "my_fold_left on strings goes from left to right"
    (my_fold_left (fun acc s -> acc ^ s) "" ["a"; "b"; "c"] = "abc");;
let () = check "my_fold_left [] returns the accumulator" (my_fold_left (+) 42 [] = 42);;
let () = check "my_fold_left on 10 000 numbers" (my_fold_left (+) 0 (upto 1 10000) = 50005000);;

let () = summary 38;;
