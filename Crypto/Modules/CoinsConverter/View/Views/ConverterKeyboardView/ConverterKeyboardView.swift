//
//  ConverterKeyboardView.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 4/29/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

typealias ConverterKeyboardViewSymbolClosure = (_ symbol: String) -> ()
typealias ConverterKeyboardViewClosure = () -> ()

class ConverterKeyboardView: UIView {

    // MARK: - Outlets
    @IBOutlet var symbolsBtns: [ButtonRect]!
    @IBOutlet weak var deleteBtn: ButtonRect!
    @IBOutlet weak var clearBtn: ButtonRect!
    @IBOutlet weak var doneBtn: ButtonRect!
    
    // MARK: - Class methods
    class func view() -> ConverterKeyboardView {
        let view: ConverterKeyboardView = ConverterKeyboardView.nib()
        view.setupUI()
        return view
    }
    
    // MARK: - Public methods
    func onSymbol(completion: @escaping ConverterKeyboardViewSymbolClosure) {
        for btn in symbolsBtns {
            btn.onTap {
                completion(btn.titleLabel?.text ?? "")
            }
        }
    }
    
    func onDone(completion: @escaping ConverterKeyboardViewClosure) {
        doneBtn.onTap {
            completion()
        }
    }
    
    func onClear(completion: @escaping ConverterKeyboardViewClosure) {
        clearBtn.onTap {
            completion()
        }
    }
    
    func onDelete(completion: @escaping ConverterKeyboardViewClosure) {
        deleteBtn.onTap {
            completion()
        }
    }
    
    // MARK: - Private methods
    private func setupUI() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

}
