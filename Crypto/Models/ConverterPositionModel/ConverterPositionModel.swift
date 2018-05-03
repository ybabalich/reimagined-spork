//
//  ConverterPositionModel.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 5/2/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation

enum ConverterPositionType: Equatable {
    case coin(name: String)
    case currency(type: App.CurrencyType)
    
    // MARK: - Variables
    var rawValue: String {
        switch self {
        case .coin(name: let coinName):
            return coinName
        case .currency(type: let currencyName):
            return currencyName.rawValue
        }
    }
    var isCoin: Bool {
        return self == .coin(name: self.rawValue)
    }
    var isCurrency: Bool {
        if let currencyType = App.CurrencyType(rawValue: self.rawValue) {
            return self == .currency(type: currencyType)
        } else {
            return false
        }
    }
    
    // MARK: - Equatable
    static func ==(lhs: ConverterPositionType, rhs: ConverterPositionType) -> Bool {
        switch (lhs, rhs) {
        case (.coin(let leftName), .coin(let rightName)) where leftName == rightName:
            return true
        case (.currency(let leftType), .currency(let rightType)) where leftType == rightType:
            return true
        default: return false
        }
    }
}

protocol ConverterPosition {
    associatedtype Position
    
    var positionType: ConverterPositionType { get }
    var value: Double { get set }
    
    func changeType(_ positionType: ConverterPositionType)
    func isEqual(to: Position) -> Bool
    func convert(by: Position) -> Double
}

class AnyConverterPosition<P: ConverterPosition>: ConverterPosition {
    
    // MARK: - Variables
    var positionType: ConverterPositionType
    var value: Double {
        get {
            return originalPosition.value
        }
        set {
            originalPosition.value = newValue
        }
    }
    var originalPosition: P
    fileprivate var _changeTypeFunc: (ConverterPositionType) -> ()
    fileprivate var _isEqual: (P) -> Bool
    fileprivate var _convert: (P) -> Double
    
    // MARK: - Initializers
    init<T: ConverterPosition>(_ position: T) where T.Position == P {
        originalPosition = position as! P
        positionType = position.positionType
        _changeTypeFunc = position.changeType
        _isEqual = position.isEqual
        _convert = position.convert
    }
    
    // MARK: - Public methods
    func changeType(_ positionType: ConverterPositionType) {
        _changeTypeFunc(positionType)
    }
    
    func isEqual(to: P) -> Bool {
        return _isEqual(to)
    }
    
    func convert(by: P) -> Double {
        return _convert(by)
    }
}

class ConverterPositionModel: ConverterPosition {
    
    // MARK: - Variables
    var positionType: ConverterPositionType
    var value: Double
    
    // MARK: - Initializers
    init(positionType: ConverterPositionType) {
        self.positionType = positionType
        value = 0
    }
    
    // MARK: - Public methods
    func changeType(_ positionType: ConverterPositionType) {
        self.positionType = positionType
    }
    
    func isEqual(to: ConverterPositionModel) -> Bool {
        return true
    }
    
    func convert(by: ConverterPositionModel) -> Double {
        return value + 100
    }
    
}
