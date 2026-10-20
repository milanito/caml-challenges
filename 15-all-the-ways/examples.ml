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

(* ===== Exercise 15 · All the Ways ===== *)

let explode s = List.init (String.length s) (String.get s);;
let implode l = String.init (List.length l) (List.nth l);;

(* the order of the results does not matter: we sort them before comparing *)
let sorted l = List.sort compare l;;

let () = check "subsets []" (subsets ([] : int list) = [[]]);;
let () = check "subsets [1]" (sorted (subsets [1]) = [[]; [1]]);;
let () = check "subsets [1; 2; 3]"
    (sorted (subsets [1; 2; 3]) = [[]; [1]; [1; 2]; [1; 2; 3]; [1; 3]; [2]; [2; 3]; [3]]);;
let () = check "subsets: 2^10 = 1024 subsets of 10 elements"
    (List.length (subsets [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]) = 1024);;
let () = check "subsets on chars"
    (sorted (subsets ['a'; 'b']) = [[]; ['a']; ['a'; 'b']; ['b']]);;

let () = check "permutations []" (permutations ([] : int list) = [[]]);;
let () = check "permutations [1]" (permutations [1] = [[1]]);;
let () = check "permutations [1; 2]" (sorted (permutations [1; 2]) = [[1; 2]; [2; 1]]);;
let () = check "permutations [1; 2; 3]"
    (sorted (permutations [1; 2; 3])
     = [[1; 2; 3]; [1; 3; 2]; [2; 1; 3]; [2; 3; 1]; [3; 1; 2]; [3; 2; 1]]);;
let () = check "permutations: 7! = 5040 permutations of 7 elements"
    (List.length (permutations [1; 2; 3; 4; 5; 6; 7]) = 5040);;
let () = check "permutations: all different"
    (let p = sorted (permutations [1; 2; 3; 4; 5]) in
     List.length p = 120 && List.length (List.sort_uniq compare p) = 120);;
let () = check "SILENT is an anagram of LISTEN"
    (List.mem (explode "SILENT") (permutations (explode "LISTEN")));;

let () = check "combinations 0 = [[]]" (combinations 0 [1; 2; 3] = [[]]);;
let () = check "combinations 1" (sorted (combinations 1 [1; 2; 3]) = [[1]; [2]; [3]]);;
let () = check "combinations 2 of 4"
    (sorted (combinations 2 [1; 2; 3; 4]) = [[1; 2]; [1; 3]; [1; 4]; [2; 3]; [2; 4]; [3; 4]]);;
let () = check "combinations 3 of 3" (combinations 3 [1; 2; 3] = [[1; 2; 3]]);;
let () = check "combinations 5 of 3 = []" (combinations 5 [1; 2; 3] = []);;
let () = check "combinations 3 of 10: 120 teams" (List.length (combinations 3 [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]) = 120);;
let () = check "combinations 6 of 20: 38 760 tickets"
    (List.length (combinations 6 [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20]) = 38760);;
let () = check "combinations (-1) raises Invalid_argument" (raises_invalid (fun () -> combinations (-1) [1; 2]));;

(* the salesman's map:   B(0,4) ---- C(3,4)
                            |   E(1,2)  |
                         A(0,0) ---- D(3,0)       distances: |x1-x2| + |y1-y2| *)
let cities = [('A', (0, 0)); ('B', (0, 4)); ('C', (3, 4)); ('D', (3, 0)); ('E', (1, 2))];;
let dist a b =
  let (x1, y1) = List.assoc a cities in
  let (x2, y2) = List.assoc b cities in
  abs (x1 - x2) + abs (y1 - y2);;

let () = check "shortest_tour with no other city" (shortest_tour dist 'A' [] = 0);;
let () = check "shortest_tour with one other city (there and back)" (shortest_tour dist 'A' ['B'] = 8);;
let () = check "shortest_tour around the rectangle A B C D" (shortest_tour dist 'A' ['B'; 'C'; 'D'] = 14);;
let () = check "shortest_tour with the 5 cities (E is in the middle)" (shortest_tour dist 'A' ['B'; 'C'; 'D'; 'E'] = 16);;
let () = check "shortest_tour does not depend on the order of the list"
    (shortest_tour dist 'A' ['E'; 'D'; 'C'; 'B'] = 16);;

let () = summary 25;;
