//
//  Button.swift
//  Sash
//
//  Created by Yaroslav Babalich on 5/27/17.
//  Copyright © 2017 Yaroslav Babalich. All rights reserved.
//

import UIKit

protocol ButtonProtocol {
    func disableWithAlpha(disable: Bool)
}

typealias ButtonTapClosure = () -> ()

class Button: UIButton {
    
    // MARK: - Variables
    var highlightedColor: UIColor?
    var highlightedAlpha: CGFloat?
    var tapClosure: ButtonTapClosure?
    fileprivate var oldBackgroundColor: UIColor?
    fileprivate var oldAlpha: CGFloat = 1
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public methods
    public func onTap(completion: @escaping ButtonTapClosure) {
        tapClosure = completion
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let highlightedColor = highlightedColor {
            oldBackgroundColor = backgroundColor
            backgroundColor = highlightedColor
        }
        
        if let highlightedAlpha = highlightedAlpha {
            oldAlpha = alpha
            alpha = highlightedAlpha
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = highlightedColor {
            backgroundColor = oldBackgroundColor
        }
        
        if let _ = highlightedAlpha {
            alpha = oldAlpha
        }
        tapClosure?()
    }
}

extension Button: ButtonProtocol {
    func disableWithAlpha(disable: Bool) {
        isEnabled = !disable
        if let color = backgroundColor {
            backgroundColor = (disable) ? color.withAlphaComponent(0.5) : color.withAlphaComponent(1.0)
        } else {
            alpha = (disable) ? 0.5 : 1.0
        }
    }
}
