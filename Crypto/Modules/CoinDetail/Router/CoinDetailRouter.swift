//
//  CoinDetailCoinDetailRouter.swift
//  Crypto
//
//  Created by  on 27/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CoinDetailRouter {

}

extension CoinDetailRouter: CoinDetailRouterInput {
    func showConverter() {
        let converterVC = UIStoryboard.main().instantiateViewController(withIdentifier: App.StoryboardName.coinsConverterVC)
        navigationVC.show(converterVC, sender: nil)
    }
}
