//
//  GradientView.swift
//  AIDAApp
//
//  Created by İdris Yıldız on 25.02.2019.
//  Copyright © 2022 gidysoft All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

class GradientView{
    
    public static func makeViewGradient(view: UIView, firstColor: UIColor, secondColor: UIColor, backgroundImage:UIImage? = UIImage()){
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        let imageView: UIImageView = UIImageView(image: backgroundImage)
        imageView.frame = CGRect(x: 0.0, y: 20.0, width: UIScreen.main.bounds.width, height: 350)
        imageView.contentMode = .bottom
        view.layer.insertSublayer(gradient, at: 0)
        view.layer.insertSublayer(imageView.layer, at: 1)
    }
}
