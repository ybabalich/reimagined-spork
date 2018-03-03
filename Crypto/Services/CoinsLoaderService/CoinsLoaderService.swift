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
    }
    
    // MARK: - Private methods
    func load(url: URL, completion: @escaping CoinsLoaderResponse) {
        let request = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
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
    
    func loadPrices(in currencies: [String], to coinsNames: [String], completion: () -> ()) {
        //XBTY
        let stringUrl = "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=BTC,USD,EUR,UAH"
        let request = URLSession.shared.dataTask(with: URL(string: stringUrl)!) { (data, urlResponse, error) in
            
        }
        request.resume()
    }
}

extension CoinsLoaderService: CoinsLoader {
    
}


