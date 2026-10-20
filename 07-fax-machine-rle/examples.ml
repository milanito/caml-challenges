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

(* ===== Exercise 07 · The Fax Machine ===== *)

let explode s = List.init (String.length s) (String.get s);;
let implode l = String.init (List.length l) (List.nth l);;

(* the example of the story: 67 pixels *)
let fax_line =
  String.make 12 'W' ^ "B" ^ String.make 12 'W' ^ String.make 3 'B'
  ^ String.make 24 'W' ^ "B" ^ String.make 14 'W';;

(* a small bitmap *)
let heart = [
  ".##...##.";
  "#########";
  "#########";
  ".#######.";
  "..#####..";
  "...###...";
  "....#....";
];;

let () = check "rle_encode []" (rle_encode ([] : int list) = []);;
let () = check "rle_encode [1; 1; 2; 3; 3; 3]" (rle_encode [1; 1; 2; 3; 3; 3] = [(2, 1); (1, 2); (3, 3)]);;
let () = check "rle_encode with a single run" (rle_encode ['z'; 'z'; 'z'; 'z'] = [(4, 'z')]);;
let () = check "rle_encode with no repetition" (rle_encode [1; 2; 3] = [(1, 1); (1, 2); (1, 3)]);;
let () = check "rle_encode: same letter comes back later" (rle_encode ['a'; 'a'; 'b'; 'a'] = [(2, 'a'); (1, 'b'); (1, 'a')]);;
let () = check "rle_encode on booleans" (rle_encode [true; true; false] = [(2, true); (1, false)]);;
let () = check "rle_encode on the fax line"
    (rle_encode (explode fax_line)
     = [(12, 'W'); (1, 'B'); (12, 'W'); (3, 'B'); (24, 'W'); (1, 'B'); (14, 'W')]);;

let () = check "rle_decode []" (rle_decode ([] : (int * int) list) = []);;
let () = check "rle_decode" (rle_decode [(3, 'x'); (2, 'y')] = ['x'; 'x'; 'x'; 'y'; 'y']);;
let () = check "rle_decode of the fax line"
    (implode (rle_decode [(12, 'W'); (1, 'B'); (12, 'W'); (3, 'B'); (24, 'W'); (1, 'B'); (14, 'W')]) = fax_line);;
let () = check "rle_decode with a zero count raises Invalid_argument" (raises_invalid (fun () -> rle_decode [(0, 'a')]));;
let () = check "rle_decode with a negative count raises Invalid_argument" (raises_invalid (fun () -> rle_decode [(2, 'a'); (-1, 'b')]));;

let () = check "decode (encode l) = l on several lists"
    (let all_ok l = rle_decode (rle_encode l) = l in
     all_ok [1; 1; 1; 2; 2; 3] && all_ok [] && all_ok [5] && all_ok (explode "mississippi"));;
let () = check "the heart survives a round trip"
    (let rec ok = function
        | [] -> true
        | row :: rest -> implode (rle_decode (rle_encode (explode row))) = row && ok rest
     in ok heart);;
let () = check "the heart: 63 pixels become only 19 runs"
    (let rec runs = function
        | [] -> 0
        | row :: rest -> List.length (rle_encode (explode row)) + runs rest
     in runs heart = 19);;

let () = check "longest_run on DNA" (longest_run (explode "AACCCGTTTTGGA") = (4, 'T'));;
let () = check "longest_run: the first one wins on a tie" (longest_run [1; 1; 2; 2; 3] = (2, 1));;
let () = check "longest_run of a single element" (longest_run ['q'] = (1, 'q'));;
let () = check "longest_run on a long run at the end" (longest_run [1; 2; 3; 3; 3] = (3, 3));;
let () = check "longest_run [] raises Failure" (raises_failure (fun () -> longest_run ([] : int list)));;

let () = summary 20;;

(* A little show: the heart, compressed with YOUR encoder *)
let show_heart () =
  List.iter
    (fun row ->
       let pairs = rle_encode (explode row) in
       Printf.printf "%s   %s\n" row
         (String.concat " " (List.map (fun (n, c) -> Printf.sprintf "%d%c" n c) pairs)))
    heart;;

let () = print_endline "\nThe heart, row by row, with its compressed form:";;
let () = show_heart ();;
