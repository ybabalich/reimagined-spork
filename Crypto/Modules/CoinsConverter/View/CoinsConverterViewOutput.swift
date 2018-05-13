//
//  CoinsConverterCoinsConverterViewOutput.swift
//  Crypto
//
//  Created by  on 28/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

protocol CoinsConverterViewOutput {
    func viewIsReady()
    func didChange(value: Double)
    func didTapReplaceBtn()
}
