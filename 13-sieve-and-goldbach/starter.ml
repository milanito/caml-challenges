(* 13 · Sieve & Goldbach
   Replace every  failwith "TODO"  with your own code. *)

(* Given to you (exercise 01): range a b = [a; a+1; ...; b] *)
let rec range a b = if a > b then [] else a :: range (a + 1) b;;

(* 1. The sieve. The list starts with a prime p: keep it, remove the multiples
      of p from the rest, and continue.
      sieve (range 2 20) = [2; 3; 5; 7; 11; 13; 17; 19] *)
let sieve (candidates : int list) : int list = failwith "TODO";;

(* 2. all the primes <= n   ([] if n < 2) *)
let primes_upto (n : int) : int list = failwith "TODO";;

(* 3. (p, q) with p + q = n, both prime, p as small as possible.
      Raise Invalid_argument unless n is even and >= 4 *)
let goldbach (n : int) : int * int = failwith "TODO";;

(* 4. number of ways to write n = p + q with p <= q, both prime.
      Same condition on n as goldbach. *)
let count_goldbach (n : int) : int = failwith "TODO";;

(* 5. all pairs of primes (p, p + 2) with p + 2 <= n *)
let twin_primes (n : int) : (int * int) list = failwith "TODO";;
