//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Yarin Belker on 13/10/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
	let coinRateFromBTC: Double
	let asset_id_quote: String
	var coinRateFromBTCString: String {
		return String(format: "%.2f", coinRateFromBTC)
	}
	
	
}
