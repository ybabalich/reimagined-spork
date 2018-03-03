//
//  Global.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/28/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import Foundation

public func ui(_ closure: @escaping () -> ()){
    DispatchQueue.main.async(execute: closure)
}
