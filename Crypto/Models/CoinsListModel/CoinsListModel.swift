//
//  CoinsListModel.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/20/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import SwiftyJSON

struct CoinsListModel: ServerModel {

    // MARK: - Variables
    var response: String
    var message: String
    var baseImageUrl: String?
    var baseLinkUrl: String?
    var elements: [Coin]
    
    // MARK: - ServerModel
    init?(server data: Any?) {
        guard let data = data else { return nil }
        let json = JSON(data)
        response = json["Response"].stringValue
        message = json["Message"].stringValue
        baseImageUrl = json["BaseImageUrl"].string
        baseLinkUrl = json["BaseLinkUrl"].string
        let baseImageURL = self.baseImageUrl
        elements = json["Data"].dictionary!.values.map({ (json) -> Coin in
            return CoinModel(server: json, baseImageUrl: baseImageURL)!
        })
    }
}
