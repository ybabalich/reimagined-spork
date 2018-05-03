//
//  CoinsConverterAssembly.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 4/29/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class CoinsConverterAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CoinsConverterRouter.self) { r in
            return CoinsConverterRouter()
        }
        
        container.register(CoinsConverterInteractorInput.self) { (r, presenter: CoinsConverterPresenter) in
            let interactor = CoinsConverterInteractor()
            interactor.output = presenter
            return interactor
        }
        
        container.register(CoinsConverterRouterInput.self) { r in
            return CoinsConverterRouter()
        }
        
        container.register(CoinsConverterViewOutput.self) { (r, vc: CoinsConverterViewController) in
            let presenter = CoinsConverterPresenter()
            presenter.view = vc
            presenter.interactor = container.resolve(CoinsConverterInteractorInput.self, argument: presenter)
            presenter.router = container.resolve(CoinsConverterRouterInput.self)
            return presenter
        }
        
        container.storyboardInitCompleted(CoinsConverterViewController.self) { (resolver, viewController) in
            viewController.output = resolver.resolve(CoinsConverterViewOutput.self, argument: viewController)
            //            viewController.settings = resolver.resolve(CryptoSettings.self)
        }
        
        container.register(CoinsConverterViewController.self) { (resolver) in
            let viewController = CoinsConverterViewController()
            viewController.output = resolver.resolve(CoinsConverterViewOutput.self, argument: viewController)
            //            viewController.settings = resolver.resolve(CryptoSettings.self)
            return viewController
        }
        
    }
    
    func loaded(resolver: Resolver) {
    }
    
}
