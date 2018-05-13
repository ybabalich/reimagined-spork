//
//  CoinsConverterCoinsConverterPresenter.swift
//  Crypto
//
//  Created by  on 28/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

class CoinsConverterPresenter: CoinsConverterModuleInput {

    weak var view: CoinsConverterViewInput!
    var interactor: CoinsConverterInteractorInput!
    var router: CoinsConverterRouterInput!

    
}

extension CoinsConverterPresenter: CoinsConverterViewOutput {
    func viewIsReady() {
        
    }
    
    func didChange(value: Double) {
        interactor.didChange(value: value)
    }
    
    func didTapReplaceBtn() {
        interactor.replacePositions()
    }
}

extension CoinsConverterPresenter: CoinsConverterInteractorOutput {
    func didUpdateResult(value: Double) {
        view.updateConvertedResult(value: value)
    }
}
