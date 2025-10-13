open Trading_backtester

let () =
  let result = Connection.get_response "https://yahoo-finance15.p.rapidapi.com/api/v1/markets/insider-trades" in 
    print_endline result.body

