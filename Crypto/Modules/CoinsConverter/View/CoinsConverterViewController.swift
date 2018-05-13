//
//  CoinsConverterCoinsConverterViewController.swift
//  Crypto
//
//  Created by  on 28/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CoinsConverterViewController: BaseViewController {

    // MARK: - Variables
    @IBOutlet weak var baseValuesView: UIView!
    @IBOutlet weak var baseKeyboardView: UIView!
    
    // MARK: - Variables
    var output: CoinsConverterViewOutput!
    override var navigationTitle: String {
        return "Converter"
    }
    private var valuesView: ConverterValuesView?
    private var keyboardView: ConverterKeyboardView?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        output.viewIsReady()
    }
    
    // MARK: - Private methods
    private func setupViews() {
        //values view
        valuesView = ConverterValuesView.view()
        baseValuesView.addSubview(valuesView!)
        valuesView?.alignExpandToSuperview()
        
        //events
        valuesView?.onReplace { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.output.didTapReplaceBtn()
        }
        
        //keyboard view
        keyboardView = ConverterKeyboardView.view()
        baseKeyboardView.addSubview(keyboardView!)
        keyboardView?.alignExpandToSuperview()
        
        //events
        keyboardView?.onSymbol { [weak self] (symbol) in
            guard let strongSelf = self else { return }
            strongSelf.addSymbol(symbol)
        }
        keyboardView?.onClear { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.removeSymbols()
        }
        keyboardView?.onDelete { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.removeLastSymbol()
            
        }
    }
    
    private func addSymbol(_ symbol: String) {
        if let valuesView = valuesView {
            let fieldText = valuesView.fieldText
            var resultString = fieldText
            let dotSymbol = "."
            if symbol == dotSymbol, !fieldText.contains(dotSymbol) {
                resultString.append(dotSymbol)
            } else if symbol != dotSymbol {
                if fieldText.count == 1 && fieldText == "0" {
                    resultString = symbol
                } else {
                    resultString.append(symbol)
                }
            }
            valuesView.fieldText = resultString
            output.didChange(value: valuesView.fieldDoubleValue)
        }
    }
    
    private func removeSymbols() {
        if let valuesView = valuesView {
            valuesView.fieldText = "0"
            output.didChange(value: valuesView.fieldDoubleValue)
        }
    }
    
    private func removeLastSymbol() {
        if let valuesView = valuesView {
            if valuesView.fieldText.count != 1 {
                valuesView.fieldText.removeLast()
                output.didChange(value: valuesView.fieldDoubleValue)
            } else {
                removeSymbols()
            }
        }
    }
}

extension CoinsConverterViewController: CoinsConverterViewInput {
    func setupInitialState() {
    }
    
    func updateConvertedResult(value: Double) {
        valuesView?.bottomField.text = "\(value)"
    }
}
