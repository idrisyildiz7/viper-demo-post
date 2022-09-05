//
//  CustomTabBar.swift

//  Created by gidysoft on 9.03.2019.
//  Copyright © 2019 gidysoft.com. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBar : UITabBar {
    
    @IBInspectable var height: CGFloat = 55.0
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            
            if #available(iOS 11.0, *) {
                sizeThatFits.height = height + window.safeAreaInsets.bottom
            } else {
                sizeThatFits.height = height
            }
        }
        return sizeThatFits
    }
}
