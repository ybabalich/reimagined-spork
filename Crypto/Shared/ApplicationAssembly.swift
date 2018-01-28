//
//  ApplicationAssembly.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/20/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class ApplicationAssembly {
    
    // MARK: - Singleton
    static let assembler: Assembler  = {
        return Assembler([
            SharedAssembly(),
            CoinsAssembly()
            ])
    }()
}

//extension SwinjectStoryboard {
//    class func setup() {
//        defaultContainer = ApplicationAssembly.assembler.resolver as! Container
//    }
//}
class SharedAssembly: Assembly {
    
    func assemble(container: Container) {
        
        //examples
//        container.register(InternetConnectionService.self) { _ in InternetConnectionService.instance }
//        container.storyboardInitCompleted(AgreementVC.self) { (r, vc) in
//            vc.settings = r.resolve(Settings.self)
//        }
    }
    
    func loaded(resolver: Resolver) {
        //
    }
}
