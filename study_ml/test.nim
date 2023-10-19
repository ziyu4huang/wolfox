import httpclient, json

proc main() =
  let url = "https://query1.finance.yahoo.com/v7/finance/quote?symbols=AAPL"

  let client = newAsyncHttpClient()
  let response = client.get(url).await()

  if response.status == "200 OK":
    let jsonResponse = parseJson(response.body)
    if jsonResponse.hasKey("quoteResponse"):
      let quoteResponse = jsonResponse["quoteResponse"]
      if quoteResponse.hasKey("result"):
        let result = quoteResponse["result"]
        if result.len > 0:
          let stockInfo = result[0]
          if stockInfo.hasKey("regularMarketPrice"):
            let price = stockInfo["regularMarketPrice"].getFloat
            echo "The latest stock price for Apple Inc. (AAPL) is: ", price
          else:
            echo "Price information not found."
        else:
          echo "No result found."
      else:
        echo "Quote response is missing result."
    else:
      echo "Response is missing quoteResponse."
  else:
    echo "Failed to get data. HTTP Status: ", response.status

# Run the main procedure
main()

