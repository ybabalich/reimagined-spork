//
//  ButtonRect.swift
//  Sash
//
//  Created by Yaroslav Babalich on 2/16/17.
//  Copyright © 2017 Yaroslav Babalich. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonRect: Button {

    // MARK: - Variables
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var topBorderColor: UIColor = UIColor.clear
    @IBInspectable var bottomBorderColor: UIColor = UIColor.clear
    @IBInspectable var leftBorderColor: UIColor = UIColor.clear
    @IBInspectable var rightBorderColor: UIColor = UIColor.clear
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var topBorderWidth: CGFloat = 0
    @IBInspectable var bottomBorderWidth: CGFloat = 0
    @IBInspectable var leftBorderWidth: CGFloat = 0
    @IBInspectable var rightBorderWidth: CGFloat = 0
    
    // MARK: - Drawing methods
    override func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        let minX = rect.minX
        let maxX = rect.maxX
        let minY = rect.minY
        let maxY = rect.maxY
        
        context.move(to: CGPoint(x: minX, y: minY))
        context.setStrokeColor(self.topBorderColor.cgColor)
        context.setLineWidth(self.topBorderWidth)
        context.addLine(to: CGPoint(x: maxX, y: minY))
        context.strokePath()
        
        context.move(to: CGPoint(x: maxX, y: minY))
        context.setStrokeColor(self.rightBorderColor.cgColor)
        context.setLineWidth(self.rightBorderWidth)
        context.addLine(to: CGPoint(x: maxX, y: maxY))
        context.strokePath()
        
        context.move(to: CGPoint(x: maxX, y: maxY))
        context.setStrokeColor(self.bottomBorderColor.cgColor)
        context.setLineWidth(self.bottomBorderWidth)
        context.addLine(to: CGPoint(x: minX, y: maxY))
        context.strokePath()
        
        context.move(to: CGPoint(x: minX, y: maxY))
        context.setStrokeColor(self.leftBorderColor.cgColor)
        context.setLineWidth(self.leftBorderWidth)
        context.addLine(to: CGPoint(x: minX, y: minY))
        context.strokePath()
    }
}
