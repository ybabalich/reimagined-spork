//
//  Settings.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 3/3/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class Settings: UserDefaults, CryptoSettings {
    
    // MARK: - Singleton
    static let instance: CryptoSettings = Settings()
    
    // MARK: - CryptoSettings
    private let kappLaunchCountKey = "kappLaunchCountKey"
    var appLaunchCount: Int {
        get {
            return integer(forKey: kappLaunchCountKey)
        }
        set {
            set(newValue, forKey: kappLaunchCountKey)
        }
    }
    
    var isFirstAppLaunch: Bool {
        return appLaunchCount == 0
    }
    
    private let kcurrencyTypeKey = "kcurrencyTypeKey"
    var currencyType: App.CurrencyType {
        get {
            guard let currencyType = string(forKey: kcurrencyTypeKey) else { return Defines.baseCurrency() }
            return App.CurrencyType(rawValue: currencyType)!
        }
        set {
            set(newValue.rawValue, forKey: kcurrencyTypeKey)
        }
    }
}
