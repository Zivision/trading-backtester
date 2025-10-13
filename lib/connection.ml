open Cohttp_lwt_unix
open Cohttp
open Lwt
open Types

(* Connect to a given url *)
let get_connect_api api = 
  let uri = Uri.of_string api.uri in
  (* Place holder headers, Will add better solution later *)
  let headers = Header.add (Header.init ()) api.h1 api.h2 in
    (* Connect to the uri and retrieve body and response*)
  Client.call ~headers `GET uri >>= fun (res, body) -> 
    body |> Cohttp_lwt.Body.to_string >|= fun body -> {
      code = res |> Response.status |> Code.code_of_status;
      headers = res |> Response.headers |> Header.to_string;
      body = body;
    } 