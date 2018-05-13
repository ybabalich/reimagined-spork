//
//  UITableViewExtension.swift
//  Hashtag
//
//  Created by Yaroslav Babalich on 12/11/16.
//  Copyright © 2016 PxToday. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func reusableTableCell(cellClass: AnyClass!) -> UITableViewCell! {
        var cellClassName: String! = NSStringFromClass(cellClass)
        cellClassName = cellClassName.characters.split{$0 == "."}.map(String.init)[1]
        var cell = self.dequeueReusableCell(withIdentifier: cellClassName)
        if (cell == nil) {
            let cellNib: UINib! = UINib(nibName: cellClassName, bundle: Bundle.main)
            self.register(cellNib, forCellReuseIdentifier: cellClassName)
            cell = self.dequeueReusableCell(withIdentifier: cellClassName)
        }
        return cell!
    }
}
