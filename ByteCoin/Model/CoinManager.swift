//
//  CoinManager.swift
//  ByteCoin


import Foundation

protocol CoinManagerDelegate {
	func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
	func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "API_KEY_HERE"
	var delegate: CoinManagerDelegate?

    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

	func getCoinPrice(for currency: String) {
		let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"

		if let url = URL(string: urlString) {
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: url) { (data, response, error) in
				if error != nil {
					print(error!)
					self.delegate?.didFailWithError(error: error!)
					return
				}
				//Format the data we got back as a string to be able to print it.
				if let safeData = data {
					
					if let coin = self.parseJSON(safeData) {
						
						self.delegate?.didUpdateCoin(self, coin: coin)
					}
				}
			}
			task.resume()
		}
	}
	
	func parseJSON(_ coinData: Data) -> CoinModel? {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(CoinData.self, from: coinData)
			let rate = decodedData.rate
			let asset_id_quote = decodedData.asset_id_quote
			let coin = CoinModel(coinRateFromBTC: rate, asset_id_quote: asset_id_quote)
			
			return coin
			
		} catch {
			delegate?.didFailWithError(error: error)
			return nil
		}
	}
	
    
}
