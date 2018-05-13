//
//  CoinsListCoinsListViewOutput.swift
//  Crypto
//
//  Created by  on 20/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

protocol CoinsListViewOutput {
    func viewIsReady()
    func didChoose(coin: Coin)
    func didTapConverterBtn()
}
