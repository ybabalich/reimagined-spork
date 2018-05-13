//
//  CoinsListCoinsListRouterInput.swift
//  Crypto
//
//  Created by  on 20/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation

protocol CoinsListRouterInput {
    func showDetailScreen(for coin: Coin)
    func showConverter()
}
