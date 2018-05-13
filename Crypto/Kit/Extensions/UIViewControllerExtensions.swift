//
//  UIViewControllerExtensions.swift
//  FadFed
//
//  Created by Yaroslav Babalich on 2/5/18.
//  Copyright © 2018 Wefaaq Co. All rights reserved.
//

import UIKit

extension UIViewController {
    class func topController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
