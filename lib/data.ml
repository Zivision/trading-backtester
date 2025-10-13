(* Convert String -> JSON *)
let json_string_to_file file str = 
  let oc = open_out file in
  print_endline "Triggered";
  Fun.protect
    ~finally:(fun () -> close_out_noerr oc)
    (fun () -> output_string oc str)

let get_data = 
  let alpha_vantage: Types.network_info = {
    uri = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=demo";
    h1 = "User-Agent";
    h2 = "request";
  } in
    let result = Lwt_main.run @@ Connection.get_connect_api alpha_vantage in 
      print_endline result.headers;
      print_endline result.body;
      Printf.printf "HTTP Code: %d\n" result.code;

      json_string_to_file "alphavantage.json" result.body
;;
