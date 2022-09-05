//
//  PickerViewHandler.swift
//  viper demo
//
//  Created by İdris Yıldız on 12/2/17.
//  Copyright © 2022 gidysoft All rights reserved.
//


import Foundation
import UIKit

struct PickerIndexPath {
    var component: Int
    var row: Int
}

class PickerViewHandler: NSObject {
    let picker: UIPickerView
    var textItems: [[String]]? {
        didSet {
            picker.reloadAllComponents()
        }
    }
    var selected: PickerIndexPath?
    var onDidSelect: ((_ indexPath: PickerIndexPath)->())?
    
    init(with picker: UIPickerView) {
        self.picker = picker
        super.init()
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    func text(for indexPath: PickerIndexPath) -> String? {
        guard let items = textItems else { return nil }
        let c = indexPath.component
        let r = indexPath.row
        guard c >= 0 && c < items.count else { return nil }
        guard r >= 0 && r < items[c].count else {return nil }
        
        return items[c][r]
    }
}

extension PickerViewHandler: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return textItems?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return textItems?[component].count ?? 0
    }
}

extension PickerViewHandler: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let indexPath = PickerIndexPath(component: component, row: row)
        return text(for: indexPath) ?? "--"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = PickerIndexPath(component: component, row: row)
        let indexPath = PickerIndexPath(component: component, row: row)
        onDidSelect?(indexPath)
    }
}
