//
//  CoinsListCoinsListPresenter.swift
//  Crypto
//
//  Created by  on 20/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

class CoinsListPresenter: CoinsListModuleInput, CoinsListInteractorOutput {

    weak var view: CoinsListViewInput!
    var interactor: CoinsListInteractorInput!
    var router: CoinsListRouterInput!
    
}

extension CoinsListPresenter: CoinsListViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func didChoose(coin: Coin) {
        router.showDetailScreen(for: coin)
    }
    
    func didTapConverterBtn() {
        router.showConverter()
    }
}
