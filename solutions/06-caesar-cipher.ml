(* SOLUTION 06 · Caesar's Secret *)

let shift_char k c =
  let rot base =
    Char.chr (base + (((Char.code c - base + k) mod 26) + 26) mod 26)
  in
  if c >= 'a' && c <= 'z' then rot (Char.code 'a')
  else if c >= 'A' && c <= 'Z' then rot (Char.code 'A')
  else c;;

let rec encrypt k = function
  | [] -> []
  | c :: rest -> shift_char k c :: encrypt k rest;;

let decrypt k text = encrypt (-k) text;;

let rot13 text = encrypt 13 text;;

(* the message was: "Meet me at the old clock tower at midnight, and bring the map!" *)
let secret_shift = 7;;
