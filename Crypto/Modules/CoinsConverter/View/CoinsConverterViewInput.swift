//
//  CoinsConverterCoinsConverterViewInput.swift
//  Crypto
//
//  Created by  on 28/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

protocol CoinsConverterViewInput: class {

    /**
        @author 
        Setup initial state of the view
    */

    func setupInitialState()
    func updateConvertedResult(value: Double)
}
