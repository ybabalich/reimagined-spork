//
//  IconButton.swift
//  Sash
//
//  Created by Yaroslav Babalich on 2/21/17.
//  Copyright © 2017 Yaroslav Babalich. All rights reserved.
//

import UIKit

class IconButton: Button {
    
    // MARK: - Initialize methods
    init(icon name: String!, on tap: @escaping ButtonTapClosure) {
        super.init()
        self.setImage(UIImage(named: name), for: .normal)
        self.onTap(completion: tap)
    }
    
    convenience init(icon name: String, inset: CGFloat, _ tap: @escaping ButtonTapClosure) {
        self.init(icon: name, on: tap)
        self.imageEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
