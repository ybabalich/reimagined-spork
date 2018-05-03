//
//  ConverterFlagView.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 4/29/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class ConverterFlagView: UIView {

    struct Content {
        enum ContentType {
            case image
            case unicode
        }
        
        // MARK: - Variables
        var type: ContentType
        var text: String
        var unicodeImageString: String?
        var image: UIImage?
    }
    
    // MARK: - Outlets
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    // MARK: - Variables
    fileprivate var content: Content?

    // MARK: - Class methods
    class func view() -> ConverterFlagView {
        let view: ConverterFlagView = ConverterFlagView.nib()
        view.widthConstraint(needCreate: true)?.constant = 55
        view.heightConstraint(needCreate: true)?.constant = 45
        return view
    }
    
    // MARK: - Public methods
    func apply(content: Content) {
        self.content = content
        textLabel.text = content.text
        
        if content.type == .unicode {
            image.isHidden = true
            flagLabel.isHidden = false
            flagLabel.text = content.unicodeImageString
        } else if content.type == .image {
            image.isHidden = false
            flagLabel.isHidden = true
            image.image = content.image
        }
    }

}
