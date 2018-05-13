//
//  AppDelegate.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/7/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Firebase
import Swinject
import SwinjectStoryboard

// MARK: - Public variables
var navigationVC: UINavigationController!
var injectResolver: Resolver!

@UIApplicationMain
class AppDelegate: UIResponder {

    // MARK: - Variables
    var window: UIWindow?

    // MARK: - Private methods
    fileprivate func setupStoryboardForStart() {
        let baseVC = SwinjectStoryboard.create(name: App.StoryboardName.main,
                                               bundle: nil,
                                               container: injectResolver).instantiateViewController(withIdentifier: App.StoryboardName.coinsListVC)
        navigationVC = UINavigationController(rootViewController: baseVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationVC
        window!.makeKeyAndVisible()
    }
    
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Fabric.with([Crashlytics.self])
//        ApplicationAssembly.assembler
        let assembler = try! Assembler(assemblies: [
            SharedAssembly(),
            CoinsConverterAssembly(),
            CoinsListAssembly(),
            CoinDetailAssembly()
            ])
        injectResolver = assembler.resolver
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance()
        
        setupStoryboardForStart()
        
        //start of test code
        let coinsLoader = CoinsLoaderService()
//        coinsLoader.loadPrices(in: [.uah, .usd], to: ["BTC", "ETH"]) {
//
//        }
        //end of test code
        
        let dayTimestamp: Double = 86400 / 2
        let timestamp = Int(Date().timeIntervalSince1970 - dayTimestamp)
//        print("timestamp -> \(timestamp)")
//        coinsLoader.loadPriceHistory(in: [.usd],
//                                     to: ["BTC"],
//                                     timestamp: timestamp)
//        { (prices) in
//
//        }
        
//        coinsLoader.loadPriceHistory(in: .usd, to: "btc", timestamp: timestamp) { (prices) in
//
//        }
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

