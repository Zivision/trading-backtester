open Cohttp_lwt_unix
open Cohttp
open Lwt
open Types

(* Connect to a given url *)
let get_connect url = 
  let uri = Uri.of_string url in
  (* Place holder headers, Will add better solution later *)
  let headers = Header.add (Header.init ()) "x-rapidapi-host" "yahoo-finance15.p.rapidapi.com" in
    (* Connect to the uri and retrieve body and response*)
  Client.call ~headers `GET uri >>= fun (res, body) -> 
    let code = res |> Response.status |> Code.code_of_status in
    Printf.printf "Response code: %d\n" code;
    Printf.printf "Headers: %s\n" (res |> Response.headers |> Header.to_string);
    body |> Cohttp_lwt.Body.to_string >|= fun body -> 
      Printf.printf "Body of length: %d\n" @@ String.length body;
      let result: Types.network_response  = {
        http_code = code;
        headers = (res |> Response.headers |> Header.to_string);
        body = body;
      } in result

let get_response url = Lwt_main.run @@ get_connect url