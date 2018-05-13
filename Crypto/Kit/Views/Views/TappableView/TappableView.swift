//
//  TappableView.swift
//  FadFed
//
//  Created by Yaroslav Babalich on 11/6/17.
//  Copyright © 2017 Wefaaq Co. All rights reserved.
//

import UIKit

typealias TappableViewClosure = (TappableView) -> ()

class TappableView: UIView {
    
    // MARK: - Variables
    private var tapClosure: TappableViewClosure?
    private var isGesturesSetted: Bool = false
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupGestures()
    }
    
    // MARK: - Public methods
    public func onTap(completion: @escaping TappableViewClosure) {
        self.tapClosure = completion
    }
    
    // MARK: - Private methods
    private func setupGestures() {
        if !self.isGesturesSetted {
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TappableView.onTapEvent(gesture:))))
            self.isGesturesSetted = true
        }
    }
    
    // MARK: - Events
    @objc private func onTapEvent(gesture: UITapGestureRecognizer) {
        self.tapClosure?(self)
    }
}
