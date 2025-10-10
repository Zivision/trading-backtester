open Connection

open Lwt

let check_connection url = 
  let res =  Lwt_main.run get_connect url in 
  