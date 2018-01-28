//
//  ModelProtocols.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/20/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation

protocol ServerModel {
    var toJSON: [String: Any?] { get }
    init?(server data: Any?)
}

extension ServerModel {
    var toJSON: [String : Any?] {
        return [:]
    }
}
