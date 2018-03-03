//
//  Defines.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/8/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

struct App {
    enum Urls {
        static let site = "https://www.cryptocompare.com"
        static let api = "https://min-api.cryptocompare.com"
    }
    
    enum StoryboardName {
        static let main = "Main"
        static let coinsListVC = "CoinsListViewController"
    }
    
    enum CurrencyType: String {
        case usd = "usd"
        case eur = "eur"
        case uah = "uah"
        case rub = "rub"
    }
}

class Defines {
    class func isDev() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    class func isTest() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    class func baseListCoinsNames() -> [String] {
        return ["btc", "eth", "ltc"]
    }
    
    class func currencySymbol(by type: App.CurrencyType) -> Character {
        switch type {
        case .usd: return "$"
        case .eur: return "€"
        case .uah: return "₴"
        case .rub: return "₽"
        }
    }
}

extension UIStoryboard {
    class func main() -> UIStoryboard {
        return SwinjectStoryboard.create(name: App.StoryboardName.main, bundle: nil)
    }
}

extension SwinjectStoryboard {
    class func setup() {
        defaultContainer = ApplicationAssembly.assembler.resolver as! Container
    }
}

extension App.CurrencyType {
    static var allValues: [App.CurrencyType] {
        return [App.CurrencyType.usd, App.CurrencyType.eur, App.CurrencyType.uah, App.CurrencyType.rub]
    }
}
