(*
  Network Types
*)

(* Network Response *)
type network_response = {
  code: int;
  headers: string;
  body: string;
}

(* URL and headers (With h1 and h2 meaning "header one and header two") *)
type network_info = {
  uri: string;
  h1: string;
  h2: string;
}

(*
  Trading Types
*)

(* Price data for one day *)
type price_bar = {
  date: string;
  open_price: float;
  high_price: float;
  low_price: float;
  close_price: float;
  volume: int;
}

(* Timeseries type for JSON data*)
type timeseries = {
  symbol: string;
  price_bars: price_bar list;
}

(* Portfolio data *)
type portfolio = {
  cash: float;
  shares: int;
  transactions: int;
}

(* Signal *)
type signal = 
  | Buy
  | Sell
  | Hold