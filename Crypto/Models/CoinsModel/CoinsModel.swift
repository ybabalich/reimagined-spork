//
//  CoinsListModel.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/20/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import SwiftyJSON

protocol EquatableObject {
    static func ==(lhs: Self, rhs: Self) -> Bool
}

protocol PriceValue {
    associatedtype V
    
    var currency: App.CurrencyType { get set }
    var value: V { get set }
}

struct Value<V>: PriceValue {
    var value: V
    var currency: App.CurrencyType
}

protocol Coin {
    var identifier: String { get }
    var name: String { get }
    var coinName: String? { get }
    var fullName: String? { get }
    var overviewUrl: String? { get }
    var imageUrl: String? { get }
    var algorithm: String? { get }
    var proofType: String? { get }
    var sortOrder: Int? { get }
    var price: PriceModel? { get set }
    var history: History { get set }
}

class History {
    
    // MARK: - Variables
    let coinName: String
    var oneDayAgo: Value<Double>?
    
    // MARK: - Initializers
    init(coinName: String) {
        self.coinName = coinName
    }
    
    // MARK: - Public methods
    func loadOneDayAgoPrice(completion: @escaping () -> ()) {
        let coinsLoader = CoinsLoaderService()
        let dayTimestamp: Double = 86400
        let timestamp = Int(Date().timeIntervalSince1970 - dayTimestamp)
        coinsLoader.loadPriceHistory(in: .usd,
                                     to: coinName,
                                     timestamp: timestamp)
        { [weak self] (value) in
            guard let strongSelf = self else { completion(); return }
            strongSelf.oneDayAgo = value
            completion()
        }
    }
}

struct PriceModel: ServerModel {
    // MARK: - Variables
    var coinName: String
    var values: [Value<Double>]
    
    // MARK: - ServerModel
    init?(server data: Any?, coinName: String) {
        self.init(server: data)
        self.coinName = coinName
    }
    
    init?(server data: Any?) {
        guard let data = data else { return nil }
        let json = JSON(data)
        coinName = ""
        values = []
        let dictionary = json.dictionaryValue
        dictionary.keys.forEach { (key) in
            if let currency = App.CurrencyType(rawValue: key.lowercased()) {
                let priceValue = Value(value: dictionary[key]!.doubleValue, currency: currency)
                values.append(priceValue)
            }
        }
    }
    
    // MARK: - Public methods
    func isEqual(to coinName: String) -> Bool {
        return self.coinName == coinName
    }
    
    func getValue(by type: App.CurrencyType) -> Double {
        for value in values {
            if value.currency == type {
                return value.value
            }
        }
        print("ERROR! PriceModel.getPrice returned 0!")
        return 0
    }
}

extension Array where Iterator.Element == PriceModel {
    func element(by coinName: String) -> PriceModel? {
        var result: PriceModel?
        forEach { (price) in
            if (price as PriceModel).isEqual(to: coinName) {
                result = price
            }
        }
        return result
    }
}

class CoinModel: ServerModel, Coin {
    // MARK: - EquatableObject
    static func ==(lhs: CoinModel, rhs: CoinModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    // MARK: - Variables
    var identifier: String
    var name: String
    var coinName: String?
    var fullName: String?
    var overviewUrl: String?
    var imageUrl: String?
    var algorithm: String?
    var proofType: String?
    var sortOrder: Int?
    var price: PriceModel?
    var history: History
    
    // MARK: - ServerModel
    convenience init?(server data: Any?, baseImageUrl: String?) {
        self.init(server: data)
        imageUrl = "\(baseImageUrl ?? "")" + (imageUrl ?? "")
    }
    
    required init?(server data: Any?) {
        guard let data = data else { return nil }
        let json = JSON(data)
        identifier = json["Id"].stringValue
        name = json["Name"].stringValue
        coinName = json["CoinName"].string
        fullName = json["FullName"].string
        overviewUrl = json["Url"].string
        imageUrl = json["ImageUrl"].string
        algorithm = json["Algorithm"].string
        proofType = json["ProofType"].string
        sortOrder = json["SortOrder"].int
        history = History(coinName: name)
    }
    
    init(identifier: String, name: String, coinName: String?, fullName: String?, imageUrl: String?) {
        self.identifier = identifier
        self.name = name
        self.coinName = coinName
        self.fullName = fullName
        self.imageUrl = imageUrl
        self.history = History(coinName: name)
    }

}
