//
//  CoinsListCoinsListRouter.swift
//  Crypto
//
//  Created by  on 20/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//
import UIKit

class CoinsListRouter {

}

extension CoinsListRouter: CoinsListRouterInput {
    func showDetailScreen(for coin: Coin) {
        let detailVC = UIStoryboard.main().instantiateViewController(withIdentifier: App.StoryboardName.coinsDetailVC)
        (detailVC as! CoinDetailViewController).coin = coin
        navigationVC.show(detailVC, sender: nil)
    }
    
    func showConverter() {
        let converterVC = UIStoryboard.main().instantiateViewController(withIdentifier: App.StoryboardName.coinsConverterVC)
        navigationVC.show(converterVC, sender: nil)
    }
}
