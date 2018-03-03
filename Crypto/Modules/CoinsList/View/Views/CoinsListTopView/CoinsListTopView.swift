//
//  CoinsListTopView.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 3/2/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CoinsListTopView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var currencyBtn: UIButton!
    
    // MARK: - Variables
    typealias CoinsListTopCurrencyTapClosure = () -> ()
    var tapClosure: CoinsListTopCurrencyTapClosure?
    
    // MARK: - Class methods
    class func view() -> CoinsListTopView {
        let view: CoinsListTopView = CoinsListTopView.nib()
        view.setupUI()
        return view
    }
    
    // MARK: - Public methods
    func setCurrency(title: String) {
        currencyBtn.setTitle(title, for: .normal)
    }
    
    func onCurrencyTap(completion: @escaping CoinsListTopCurrencyTapClosure) {
        tapClosure = completion
    }
    
    // MARK: - Private methods
    private func setupUI() {
        currencyBtn.layer.cornerRadius = 10
        currencyBtn.layer.masksToBounds = true
    }
    
    // MARK: - Events
    @IBAction func currencyBtnEvent(_ sender: UIButton) {
        tapClosure?()
    }
    
}
