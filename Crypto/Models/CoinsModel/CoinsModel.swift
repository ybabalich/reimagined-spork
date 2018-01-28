//
//  CoinsListModel.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/20/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import SwiftyJSON

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
    
    func isEqual(to: Coin) -> Bool
}

struct CoinModel: ServerModel, Coin {
    
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
    
    // MARK: - ServerModel
    init?(server data: Any?) {
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
    }
    
    // MARK: - Methods
    func isEqual(to: Coin) -> Bool {
        return identifier == to.identifier
    }
    
}
