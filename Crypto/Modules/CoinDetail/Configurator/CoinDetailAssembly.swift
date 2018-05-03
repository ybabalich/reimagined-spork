//
//  CoinDetailAssembly.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 4/27/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class CoinDetailAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CoinDetailRouter.self) { r in
            return CoinDetailRouter()
        }
        
        container.register(CoinDetailInteractorInput.self) { (r, presenter: CoinDetailPresenter) in
            let interactor = CoinDetailInteractor()
            interactor.output = presenter
            return interactor
        }
        
        container.register(CoinDetailRouterInput.self) { r in
            return CoinDetailRouter()
        }
        
        container.register(CoinDetailViewOutput.self) { (r, vc: CoinDetailViewController) in
            let presenter = CoinDetailPresenter()
            presenter.view = vc
            presenter.interactor = container.resolve(CoinDetailInteractorInput.self, argument: presenter)
            presenter.router = container.resolve(CoinDetailRouterInput.self)
            return presenter
        }
        
        container.register(CoinDetailViewController.self) { (resolver) in
            let viewController = CoinDetailViewController()
            viewController.output = resolver.resolve(CoinDetailViewOutput.self, argument: viewController)
//            viewController.settings = resolver.resolve(CryptoSettings.self)
            return viewController
        }
        
        container.storyboardInitCompleted(CoinDetailViewController.self) { (resolver, viewController) in
            viewController.output = resolver.resolve(CoinDetailViewOutput.self, argument: viewController)
//            viewController.settings = resolver.resolve(CryptoSettings.self)
        }
        
    }
    
    func loaded(resolver: Resolver) {
    }
    
}
