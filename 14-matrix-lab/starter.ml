(* 14 · The Matrix Lab
   A matrix is a list of rows: [[1; 2; 3]; [4; 5; 6]] has 2 rows and 3 columns.
   Replace every  failwith "TODO"  with your own code. *)

(* 1. swap rows and columns.  transpose [[1;2;3];[4;5;6]] = [[1;4];[2;5];[3;6]]
      transpose [] = [] *)
let transpose (m : 'a list list) : 'a list list = failwith "TODO";;

(* 2. dot product.  dot [1;2;3] [4;5;6] = 32
      Raise Invalid_argument if the lengths differ *)
let dot (u : int list) (v : int list) : int = failwith "TODO";;

(* 3. matrix product.  Raise Invalid_argument if the sizes are incompatible *)
let mat_mul (a : int list list) (b : int list list) : int list list = failwith "TODO";;

(* 4. identity matrix of size n x n.  identity 0 = [] *)
let identity (n : int) : int list list = failwith "TODO";;

(* 5. m multiplied k times by itself (m is square). k = 0 gives the identity.
      Raise Invalid_argument if k < 0 *)
let mat_pow (m : int list list) (k : int) : int list list = failwith "TODO";;

(* 6. n-th Fibonacci number, using mat_pow [[1; 1]; [1; 0]] n *)
let fib_matrix (n : int) : int = failwith "TODO";;

(* 7. quarter turn clockwise.  rotate_cw [[1;2;3];[4;5;6]] = [[4;1];[5;2];[6;3]] *)
let rotate_cw (m : 'a list list) : 'a list list = failwith "TODO";;
