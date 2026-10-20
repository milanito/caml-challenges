(* 18 · Big Numbers
   A big number is an int list of its decimal digits, LEAST significant digit first:
        12345  is  [5; 4; 3; 2; 1]
   No useless zero at the end of the list ([5; 4; 0] is NOT allowed). Zero is [0].
   Replace every  failwith "TODO"  with your own code. *)

(* 1. big_of_int 12345 = [5; 4; 3; 2; 1]     big_of_int 0 = [0]
      Raise Invalid_argument if n < 0 *)
let big_of_int (n : int) : int list = failwith "TODO";;

(* 2. addition of two big numbers (of possibly different lengths) *)
let add_big (a : int list) (b : int list) : int list = failwith "TODO";;

(* 3. multiplication by an ordinary int k >= 0.
      mul_small [5; 4; 3; 2; 1] 0 must give [0].
      Raise Invalid_argument if k < 0 *)
let mul_small (a : int list) (k : int) : int list = failwith "TODO";;

(* 4. n!   (Invalid_argument if n < 0) *)
let factorial_big (n : int) : int list = failwith "TODO";;

(* 5. n-th Fibonacci number (fib_big 0 = 0, fib_big 1 = 1) *)
let fib_big (n : int) : int list = failwith "TODO";;

(* 6. k to the power e   (k >= 0, e >= 0) *)
let power_big (k : int) (e : int) : int list = failwith "TODO";;

(* 7. sum of the digits *)
let digit_sum (a : int list) : int = failwith "TODO";;
