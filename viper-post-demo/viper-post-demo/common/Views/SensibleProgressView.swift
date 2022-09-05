//
//  SensibleProgressView.swift
//  AidaApp
//
//  Created by Vestel Dev on 6.12.2019.
//  Copyright © 2022 gidysoft All rights reserved.
//

import UIKit

@IBDesignable
class SensibleProgressView: UIView {
    
    private var progressBackgroundView: UIView!
    private var progressContentView: UIView!
    
    @IBInspectable var trackColor: UIColor = UIColor.white {
        didSet{
            self.backgroundColor = trackColor
            self.progressBackgroundView.backgroundColor = trackColor
        }}
    @IBInspectable var progressColor: UIColor = UIColor.blue {
    didSet{
        self.progressContentView.backgroundColor = progressColor
        self.layer.borderColor = progressColor.cgColor
    }}
    @IBInspectable var borderThickness: CGFloat = 2 {
    didSet{
        self.layer.borderWidth = borderThickness
    }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        build()
    
    }
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.build()
    }
    
    func build() {

        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
        
        progressBackgroundView = UIView()
        progressBackgroundView.frame.size.height = frame.size.height
        addSubview(progressBackgroundView)
        
        
        progressContentView = UIView()
        progressContentView.frame = progressBackgroundView.frame
        addSubview(progressContentView)
    }

    
    /// The current progress value. Valid Range: 0.0 ~ 1.0
    @IBInspectable  var progress: Float = 0.0 {
        didSet {
            let temp = max(0.0, progress)
            progress = min(temp, 1.0)
            
            let width = bounds.size.width * CGFloat(progress)
            progressBackgroundView.frame.size.width = width
            progressContentView.frame.size.width = width

        }
    }
    
}
