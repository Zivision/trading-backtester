open Trading_backtester

let () =
  (* Fetch URLs *)
  Data.fetch_url "https://opam.ocaml.org"
  Data.fetch_url "https://www.google.com"