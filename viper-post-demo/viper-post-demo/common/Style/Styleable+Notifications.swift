//
//  Styleable+Notifications.swift
//  viper demo
//
//  Created by İdris Yıldız on 5/9/18.
//  Copyright © 2022 gidysoft All rights reserved.
//

import Foundation

extension Notification.Name {
    static let styleDidChange = Notification.Name("StyleDidChangeNotification")
}

extension Styleable where Self: NSObjectProtocol {
    func startObservingStyle() {
        stopObservingStyle()
        NotificationCenter.default.addObserver(forName: .styleDidChange, object: nil, queue: nil) { [weak self] _ in
            self?.applyStyle()
        }
        applyStyle()
    }
    
    func stopObservingStyle() {
        NotificationCenter.default.removeObserver(self, name: .styleDidChange, object: nil)
    }
}
