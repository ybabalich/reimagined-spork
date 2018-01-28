//
//  CryptocurrencyDetailCryptocurrencyDetailPresenter.swift
//  Crypto
//
//  Created by  on 07/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

class CryptocurrencyDetailPresenter: CryptocurrencyDetailModuleInput, CryptocurrencyDetailViewOutput, CryptocurrencyDetailInteractorOutput {

    weak var view: CryptocurrencyDetailViewInput!
    var interactor: CryptocurrencyDetailInteractorInput!
    var router: CryptocurrencyDetailRouterInput!

    func viewIsReady() {

    }
}
