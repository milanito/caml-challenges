(* 04 · Rabbits of Fibonacci
   Replace every  failwith "TODO"  with your own code.
   Raise Invalid_argument (invalid_arg) when n < 0. *)

(* 1. F(0) = 0, F(1) = 1, F(n) = F(n-1) + F(n-2). Straight from the definition. *)
let fib (n : int) : int = failwith "TODO";;

(* 2. the first n Fibonacci numbers: fib_list 7 = [0; 1; 1; 2; 3; 5; 8] *)
let fib_list (n : int) : int list = failwith "TODO";;

(* 3. same result as fib, but fast: about n operations.
      Hint: carry two consecutive Fibonacci numbers as parameters. *)
let fib_fast (n : int) : int = failwith "TODO";;

(* 4. sum of the even Fibonacci numbers that are <= limit
      sum_even_fibs 100 = 2 + 8 + 34 = 44 *)
let sum_even_fibs (limit : int) : int = failwith "TODO";;
