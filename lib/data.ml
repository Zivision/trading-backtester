open Yojson.Basic.Util
open Types

(* 
  Convert String -> JSON and store it as a file. 
  for testing purposes only. 
*)
let json_string_to_file file str = 
  let oc = open_out file in
  print_endline "Triggered";
  Fun.protect
    ~finally: (fun () -> close_out_noerr oc)
    (fun () -> output_string oc str)
;;

(* Assign json values to record type price_bar*)
let parse_bar timestamp json =
  {
    date = timestamp;
    open_price  = json |> member "1. open"   |> to_string |> float_of_string;
    high_price  = json |> member "2. high"   |> to_string |> float_of_string;
    low_price   = json |> member "3. low"    |> to_string |> float_of_string;
    close_price = json |> member "4. close"  |> to_string |> float_of_string;
    volume      = json |> member "5. volume" |> to_string |>   int_of_string;
  }
;;

let parse_timeseries str =
  let json = Yojson.Basic.from_string str in 
  let meta = json |> member "Meta Data" in
  let symbol = meta |> member "2. symbol" |> to_string in
  let ts = json |> member "Time Series (5min)" |> to_assoc in
  let bars = List.map (fun (timestamp, bar_json) -> 
    print_endline timestamp;
    parse_bar timestamp bar_json;
  ) ts in {
    symbol = symbol; 
    price_bars = bars
  }

let get_data = 
  let alpha_vantage: Types.network_info = {
    uri = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=demo";
    h1 = "User-Agent";
    h2 = "request";
  } in
    let result = Lwt_main.run @@ Connection.get_connect_api alpha_vantage in 
      print_endline result.headers;
      Printf.printf "HTTP Code: %d\n" result.code;

      (*json_string_to_file "alphavantage.json" result.body*)
    let parsed_data = parse_timeseries result.body in
    print_string parsed_data.symbol

;;
