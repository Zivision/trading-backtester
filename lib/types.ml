(* Price data for onw day *)
type price_bar = {
  date: string;
  open_price: float;
  high: float;
  low: float;
  close: float;
  volume: int;
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