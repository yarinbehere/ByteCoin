//
//  ViewController.swift
//  ByteCoin


import UIKit



class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	
	var coinManager = CoinManager()
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return coinManager.currencyArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return coinManager.currencyArray[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		coinManager.getCoinPrice(for: coinManager.currencyArray[row])
		
	}
	

	@IBOutlet weak var bitcoinLabel: UILabel!
	@IBOutlet weak var currencyLabel: UILabel!
	@IBOutlet weak var currencyPicker: UIPickerView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
		currencyPicker.dataSource = self
		currencyPicker.delegate = self
		coinManager.delegate = self
    }

	
}

extension ViewController: CoinManagerDelegate {
	func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
		DispatchQueue.main.async {
			self.currencyLabel.text = coin.asset_id_quote
			self.bitcoinLabel.text = coin.coinRateFromBTCString
		}
	}
	
	func didFailWithError(error: Error) {
		print(error)
	}
	
	
}
