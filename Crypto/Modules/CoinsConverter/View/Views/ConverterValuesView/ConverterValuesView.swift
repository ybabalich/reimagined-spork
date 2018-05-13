//
//  ConverterValuesView.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 4/29/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class ConverterValuesView: UIView {

    typealias ConverterValuesViewVoidClosure = () -> ()
    
    // MARK: - Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var baseFlagTopView: UIView!
    @IBOutlet weak var baseFlagBottomView: UIView!
    
    // MARK: - Variables
    var fieldText: String {
        get {
           return topField.text ?? ""
        }
        set {
            topField.text = newValue
        }
    }
    var fieldDoubleValue: Double {
        return (fieldText.count > 0) ? Double(fieldText)! : 0
    }
    private var oldBackViewRect: CGRect = .zero
    private var replaceEventClosure: ConverterValuesViewVoidClosure?
    
    // MARK: - Class methods
    class func view() -> ConverterValuesView {
        let view: ConverterValuesView = ConverterValuesView.nib()
        view.setupView()
        return view
    }
    
    // MARK: - Public methods
    func onReplace(completion: @escaping ConverterValuesViewVoidClosure) {
        replaceEventClosure = completion
    }
    
    // MARK: - Private methods
    private func setupView() {
        //ui
        backView.layer.cornerRadius = 15
        backView.layer.masksToBounds = true
        
        //texts
        topField.text = "0"
        bottomField.text = "0"
        
        //flags view
        let topFlagView = ConverterFlagView.view()
        topFlagView.apply(content: ConverterFlagView.Content(type: .unicode, text: "USD", unicodeImageString: "🇺🇲", image: nil))
        let bottomFlagView = ConverterFlagView.view()
        bottomFlagView.apply(content: ConverterFlagView.Content(type: .image, text: "Bitcoin", unicodeImageString: nil, image: UIImage(named: "ic_bitcoin")))
        
        baseFlagTopView.addSubview(topFlagView)
        baseFlagBottomView.addSubview(bottomFlagView)
        
        topFlagView.alignExpandToSuperview()
        bottomFlagView.alignExpandToSuperview()
    }
    
    // MARK: - Events
    @IBAction func changePlacesBtnEvent(_ sender: UIButton) {
        replaceEventClosure?()
    }
}
