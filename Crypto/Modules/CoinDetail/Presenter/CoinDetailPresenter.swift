//
//  CoinDetailCoinDetailPresenter.swift
//  Crypto
//
//  Created by  on 27/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

class CoinDetailPresenter: CoinDetailModuleInput, CoinDetailViewOutput, CoinDetailInteractorOutput {

    weak var view: CoinDetailViewInput!
    var interactor: CoinDetailInteractorInput!
    var router: CoinDetailRouterInput!

    func viewIsReady() {

    }
}
