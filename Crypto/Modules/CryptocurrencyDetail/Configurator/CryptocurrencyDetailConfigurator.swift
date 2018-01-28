//
//  CryptocurrencyDetailCryptocurrencyDetailConfigurator.swift
//  Crypto
//
//  Created by  on 07/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CryptocurrencyDetailModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CryptocurrencyDetailViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: CryptocurrencyDetailViewController) {

        let router = CryptocurrencyDetailRouter()

        let presenter = CryptocurrencyDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CryptocurrencyDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
