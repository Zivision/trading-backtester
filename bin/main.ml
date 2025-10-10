open Trading_backtester

let () =
  Connection.get_body "https://yahoo-finance15.p.rapidapi.com/api/v1/markets/insider-trades"

