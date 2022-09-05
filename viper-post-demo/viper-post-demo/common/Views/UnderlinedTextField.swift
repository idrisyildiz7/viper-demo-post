//
//  UnderlinedTextField.swift
//  viper demo
//
//  Created by İdris YILDIZ on 28.05.2018.
//  Copyright © 2022 gidysoft All rights reserved.
//

import UIKit

@IBDesignable
class UnderlinedTextField: UITextField {
    
    @IBInspectable var lineColor: UIColor = StyleManager.colors.background
    @IBInspectable var lineWidth: CGFloat = 2
    @IBInspectable var intrinsicHeight: CGFloat = 40
    @IBInspectable var textLeftEdge: CGFloat = 128
    
    let textTopEdge: CGFloat = 4
    
    lazy var fillColor: UIColor = self.lineColor
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            fillColor.setStroke()
            context.setLineWidth(lineWidth)
            context.move(to: CGPoint(x: rect.minX, y: intrinsicHeight))
            context.addLine(to: CGPoint(x: rect.maxX, y: intrinsicHeight))
            context.strokePath()
        }
        //drawPlaceholder(in: placeholderRect(forBounds: rect))
    }
    
    func setupPlaceholder(withPrefix prefix: String? = nil, placeholder: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingMiddle
        let attributes: [NSAttributedString.Key: Any] = [
            .font: self.font as Any,
            .foregroundColor: StyleManager.colors.background,
            .paragraphStyle: paragraphStyle
        ]
        if let prefix = prefix {
            attributedPlaceholder = NSAttributedString(string: "\(prefix) \(placeholder)", attributes: attributes)
        } else {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.maxX, height: intrinsicHeight)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: intrinsicHeight * 0.7, y: 0, width: bounds.maxX - intrinsicHeight * 0.7, height: bounds.maxY)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.maxX - intrinsicHeight * 0.7, height: bounds.maxY)
    }
}

