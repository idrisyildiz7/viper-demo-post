//
//  AidaExtensions.swift
//  AidaApp
//
//  Created by İdris Yıldız on 20.11.2019.
//  Copyright © 2022 gidysoft All rights reserved.
//

import Foundation
import UIKit
class Utils {
    static func isValidEmail(email:String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
