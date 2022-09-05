//
//  VFitLog.swift
//  AIDAApp
//
//  Created by idris yıldız on 4.02.2019.
//  Copyright © 2022 gidysoft All rights reserved.
//

import Foundation
import  UIKit

class MyLog{
    static var shouldShowLogs:Bool!
    init(shouldShowLogs:Bool) {
        MyLog.shouldShowLogs = shouldShowLogs
    }
     static func mPrint(_ msg: Any...){
        if MyLog.shouldShowLogs{
            print("\(msg)")
        }
    }
}
