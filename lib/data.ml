(* Fetch data from URL *)
let fetch_url url = 
  match Curly.(run (Request.make ~url:url ~meth:`GET ())) with 
  | Ok r -> 
    Format.printf "Status: %d\n" r.Curly.Response.code;
    Format.printf "Headers: %a\n" Curly.Header.pp r.Curly.Response.headers;
    Format.printf "Body: %s\n" r.Curly.Response.body
  | Error e -> 
    Format.printf "Failed: %a" Curly.Error.pp e