//
//  CryptocurrencyDetailCryptocurrencyDetailInitializer.swift
//  Crypto
//
//  Created by  on 07/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CryptocurrencyDetailModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var cryptocurrencydetailViewController: CryptocurrencyDetailViewController!

    override func awakeFromNib() {

        let configurator = CryptocurrencyDetailModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: cryptocurrencydetailViewController)
    }

}
