//
//  SettingsProtocol.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 3/3/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation

protocol CryptoSettings {
    //app settings
    var appLaunchCount: Int { get set }
    var isFirstAppLaunch: Bool { get }
    
    //currency settings
    var currencyType: App.CurrencyType { get set }
}
