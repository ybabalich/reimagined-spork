//
//  CryptocurrencyDetailCryptocurrencyDetailViewController.swift
//  Crypto
//
//  Created by  on 07/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CryptocurrencyDetailViewController: UIViewController, CryptocurrencyDetailViewInput {

    var output: CryptocurrencyDetailViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: CryptocurrencyDetailViewInput
    func setupInitialState() {
    }
}
