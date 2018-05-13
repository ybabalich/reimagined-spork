//
//  CoinsConverterCoinsConverterInteractor.swift
//  Crypto
//
//  Created by on 28/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

class CoinsConverterInteractor {

    // MARK: - Variables
    weak var output: CoinsConverterInteractorOutput!
    private lazy var topPosition: AnyConverterPosition<ConverterPositionModel> = {
        return AnyConverterPosition(ConverterPositionModel(positionType: .coin(name: "BTC")))
    }()
    private lazy var bottomPosition: AnyConverterPosition<ConverterPositionModel> = {
        return AnyConverterPosition(ConverterPositionModel(positionType: .currency(type: .usd)))
    }()

    // MARK: - Private methods
    private func convertValues() {
        let convertedValue = topPosition.convert(by: bottomPosition.originalPosition)
        output.didUpdateResult(value: convertedValue)
    }
}

extension CoinsConverterInteractor: CoinsConverterInteractorInput {
    func didChange(value: Double) {
        print("value -> \(value)")
        topPosition.value = value
        convertValues()
    }
    
    func replacePositions() {
        let tempPosition = topPosition
        topPosition = bottomPosition
        bottomPosition = tempPosition
        convertValues()
    }
}
