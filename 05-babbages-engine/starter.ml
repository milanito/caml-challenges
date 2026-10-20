(* 05 · Babbage's Engine
   Replace every  failwith "TODO"  with your own code. *)

(* 1. twice f x = f (f x) *)
let twice (f : 'a -> 'a) (x : 'a) : 'a = failwith "TODO";;

(* 2. compose f g x = f (g x) *)
let compose (f : 'b -> 'c) (g : 'a -> 'b) : 'a -> 'c = failwith "TODO";;

(* 3. iterate f n x = f (f (... (f x))) with n applications of f.
      iterate f 0 x = x.   Raise Invalid_argument if n < 0 *)
let iterate (f : 'a -> 'a) (n : int) (x : 'a) : 'a = failwith "TODO";;

(* 4. tabulate f n = [f 0; f 1; ...; f (n-1)].
      Raise Invalid_argument if n < 0 *)
let tabulate (f : int -> 'a) (n : int) : 'a list = failwith "TODO";;

(* 5. differences of consecutive elements.
      differences [41; 43; 47; 53] = [2; 4; 6]
      differences [] = []   differences [7] = [] *)
let differences (lst : int list) : int list = failwith "TODO";;
