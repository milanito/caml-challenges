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

(* ===== Exercise 14 · The Matrix Lab ===== *)

let fib_matrix_m = [[1; 1]; [1; 0]];;

let () = check "transpose a 2x3 matrix" (transpose [[1; 2; 3]; [4; 5; 6]] = [[1; 4]; [2; 5]; [3; 6]]);;
let () = check "transpose a column" (transpose [[1]; [2]; [3]] = [[1; 2; 3]]);;
let () = check "transpose a row" (transpose [[1; 2; 3]] = [[1]; [2]; [3]]);;
let () = check "transpose []" (transpose ([] : int list list) = []);;
let () = check "transpose twice is the identity"
    (let m = [[1; 2; 3; 4]; [5; 6; 7; 8]; [9; 10; 11; 12]] in transpose (transpose m) = m);;
let () = check "transpose works on chars" (transpose [['a'; 'b']; ['c'; 'd']] = [['a'; 'c']; ['b'; 'd']]);;

let () = check "dot [1;2;3] [4;5;6] = 32" (dot [1; 2; 3] [4; 5; 6] = 32);;
let () = check "dot [] [] = 0" (dot [] [] = 0);;
let () = check "dot with different lengths raises Invalid_argument" (raises_invalid (fun () -> dot [1] [1; 2]));;

let () = check "mat_mul 2x3 by 3x2"
    (mat_mul [[1; 2; 3]; [4; 5; 6]] [[7; 8]; [9; 10]; [11; 12]] = [[58; 64]; [139; 154]]);;
let () = check "mat_mul 2x2 by 2x2" (mat_mul [[1; 2]; [3; 4]] [[0; 1]; [1; 0]] = [[2; 1]; [4; 3]]);;
let () = check "mat_mul is not commutative" (mat_mul [[0; 1]; [1; 0]] [[1; 2]; [3; 4]] = [[3; 4]; [1; 2]]);;
let () = check "mat_mul by a scalar matrix" (mat_mul [[2; 0]; [0; 2]] [[1; 2]; [3; 4]] = [[2; 4]; [6; 8]]);;
let () = check "mat_mul with incompatible sizes raises Invalid_argument"
    (raises_invalid (fun () -> mat_mul [[1; 2; 3]] [[1; 2]; [3; 4]]));;

let () = check "identity 1" (identity 1 = [[1]]);;
let () = check "identity 3" (identity 3 = [[1; 0; 0]; [0; 1; 0]; [0; 0; 1]]);;
let () = check "identity 0 = []" (identity 0 = []);;
let () = check "multiplying by the identity changes nothing"
    (let m = [[2; 7; 1]; [8; 2; 8]; [1; 8; 2]] in mat_mul m (identity 3) = m && mat_mul (identity 3) m = m);;

let () = check "mat_pow m 0 = identity" (mat_pow [[1; 1]; [1; 0]] 0 = identity 2);;
let () = check "mat_pow m 1 = m" (mat_pow [[1; 1]; [1; 0]] 1 = [[1; 1]; [1; 0]]);;
let () = check "mat_pow of the Fibonacci matrix" (mat_pow fib_matrix_m 10 = [[89; 55]; [55; 34]]);;
let () = check "mat_pow of a scalar matrix" (mat_pow [[2; 0]; [0; 2]] 10 = [[1024; 0]; [0; 1024]]);;
let () = check "mat_pow with k < 0 raises Invalid_argument" (raises_invalid (fun () -> mat_pow fib_matrix_m (-1)));;

let () = check "fib_matrix 0 = 0" (fib_matrix 0 = 0);;
let () = check "fib_matrix 1 = 1" (fib_matrix 1 = 1);;
let () = check "fib_matrix 10 = 55" (fib_matrix 10 = 55);;
let () = check "fib_matrix 50 = 12586269025" (fib_matrix 50 = 12586269025);;
let () = check "fib_matrix 80 = 23416728348467685" (fib_matrix 80 = 23416728348467685);;

let () = check "rotate_cw a 2x3 matrix" (rotate_cw [[1; 2; 3]; [4; 5; 6]] = [[4; 1]; [5; 2]; [6; 3]]);;
let () = check "rotate_cw a 2x2 matrix" (rotate_cw [[1; 2]; [3; 4]] = [[3; 1]; [4; 2]]);;
let () = check "four quarter turns = no turn"
    (let m = [[1; 2; 3]; [4; 5; 6]] in rotate_cw (rotate_cw (rotate_cw (rotate_cw m))) = m);;

let () = summary 31;;

(* ===== A picture, rotated four times with YOUR rotate_cw ===== *)
let picture = ["###."; "#..."; "##.."; "#..."; "#..."];;
let explode s = List.init (String.length s) (String.get s);;
let implode l = String.init (List.length l) (List.nth l);;
let show m = List.iter (fun row -> print_endline (implode row)) m; print_newline ();;

let () =
  print_endline "\nThe letter F, turned four times:\n";
  let f0 = List.map explode picture in
  let f1 = rotate_cw f0 in
  let f2 = rotate_cw f1 in
  let f3 = rotate_cw f2 in
  let f4 = rotate_cw f3 in
  List.iter show [f0; f1; f2; f3; f4];;
