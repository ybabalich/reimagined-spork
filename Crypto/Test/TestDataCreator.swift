//
//  TestDataCreator.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 4/28/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation

class TestDataCreator {
    
    // MARK: - Variables
    fileprivate lazy var symbols_en: [String] = {
        return ["a", "b", "c", "d", "e",
                "f", "g", "h", "i", "j",
                "k", "l", "m", "n", "o",
                "p", "q", "r", "s", "t",
                "u", "v", "w", "x", "y", "z"]
    }()
    
    // MARK: - Public methods
    func generateTestCoins(count: Int) -> [Coin] {
        return (0...count).compactMap { (value) -> Coin in
            return genCoin()
        }
    }
    
    // MARK: - Private methods
    private func genCoin() -> Coin {
        let identifier = "\(arc4random_uniform(1000000))"
        let name = genText(length: 20)
        let endIndex = name.index(name.startIndex, offsetBy: 5)
        let coinName: String = String(name[..<endIndex])
        let imageUrl = Bundle.main.path(forResource: "ic_bitcoin", ofType: "png")
        return CoinModel(identifier: identifier, name: name, coinName: coinName, fullName: name, imageUrl: imageUrl)
    }
    
    private func genText(length: UInt32) -> String {
        var text = ""
        for _ in 0...length {
            let randomCharacterIndex = arc4random_uniform(UInt32(symbols_en.count))
            let randomCharacter = symbols_en[Int(randomCharacterIndex)]
            text.append(randomCharacter)
        }
        return text
    }
}
