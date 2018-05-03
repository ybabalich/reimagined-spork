//
//  CoinsLoaderService.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/20/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol CoinsLoader {
    
}

typealias CoinsLoaderResponse = (CoinsListModel?, Error?) -> ()

class CoinsLoaderService: NSObject {
  
    enum ApiParamsUrl: String {
        case coinsList = "/api/data/coinlist/"
        case coinsPrice = "/data/price"
        case coinsPriceMulti = "/data/pricemulti"
        case coinsHistory = "/data/pricehistorical"
    }
    
    // MARK: - Private methods
    func loadList(completion: @escaping CoinsLoaderResponse) {
        let url = URL(string: "\(App.Urls.site)" + "\(CoinsLoaderService.ApiParamsUrl.coinsList.rawValue)")
        let request = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            let models = CoinsListModel(server: data)
            completion(models, error)
        }
        request.resume()
    }
    
    func retrieveCoins(names: [String], from coins: [Coin]) -> [Coin] {
        var result: [Coin] = []
        coins.forEach { (coin) in
            if names.contains(coin.name.lowercased()) {
                result.append(coin)
            }
        }
        return result
    }
    
    func loadPrices(in currencies: [App.CurrencyType], to coinsNames: [String], completion: @escaping ([PriceModel]) -> ()) {
        var baseUrlString = App.Urls.api + ApiParamsUrl.coinsPriceMulti.rawValue //|FIX| allocate to separate model
        //coins
        baseUrlString.append("?fsyms=")
        for (index, coinName) in coinsNames.enumerated() {
            if index != 0 {
                baseUrlString.append(",")
            }
            baseUrlString.append(coinName.uppercased())
        }
        
        //currencies
        baseUrlString.append("&tsyms=")
        for (index, currencyName) in currencies.enumerated() {
            if index != 0 {
                baseUrlString.append(",")
            }
            baseUrlString.append(currencyName.rawValue.uppercased())
        }
        
        let request = URLSession.shared.dataTask(with: URL(string: baseUrlString)!) { (data, urlResponse, error) in
            guard let data = data else { return completion([]) }
            var result: [PriceModel] = []
            let json = JSON(data) //|FIX|
            let dictionary = json.dictionaryValue
            json.dictionaryValue.keys.forEach({ (key) in
                result.append(PriceModel(server: dictionary[key]!, coinName: key)!)
            })
            completion(result)
        }
        request.resume()
    }
    
    func loadPriceHistory(in currency: App.CurrencyType,
                          to coinName: String,
                          timestamp: Int,
                          completion: @escaping (Value<Double>?) -> ())
    {
        var baseUrlString = App.Urls.api + ApiParamsUrl.coinsHistory.rawValue //|FIX| allocate to separate model
        //coins
        baseUrlString.append("?fsym=" + "\(coinName.uppercased())")
        
        //currencies
        baseUrlString.append("&tsyms=" + "\(currency.rawValue.uppercased())")
        
        //timestamp
        baseUrlString.append("&ts=" + "\(timestamp)")
        
        //request
        let request = URLSession.shared.dataTask(with: URL(string: baseUrlString)!) { (data, urlResponse, error) in
            guard let data = data else { return completion(nil) }
            var result: PriceModel?
            let json = JSON(data) //|FIX|
            let dictionary = json.dictionaryValue
            json.dictionaryValue.keys.forEach({ (key) in
                result = PriceModel(server: dictionary[key]!, coinName: key)
            })
            
            if let result = result, result.values.count > 0 {
                completion(result.values[0])
            } else {
                completion(nil)
            }
        }
        request.resume()
    }
}

extension CoinsLoaderService: CoinsLoader {
    
}
