//
//  TableViewHandler.swift
//
//  Created by İdris Yıldız on 9/15/17.
//  Copyright © 2017 İdris Yıldız. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableCell {
    func configure(with data: Any)
}

enum TableHandlerError: Error {
    case noData
    case invalidSection(Int)
    case invalidIndex(IndexPath)
}

class TableViewHandler<T: ConfigurableCell>: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView
    
    var data: [[Any]]?
    
    // Accepts nil, String or UIView
    var headers: [Any?]? {
        willSet {
            let sectionsCnt = data?.count ?? 0
            let headersCnt = newValue?.count ?? sectionsCnt
            assert(sectionsCnt == headersCnt, "TableViewHandler: Number of sections in data does not match with number of headers. Use nil for every empty header.")
        }
    }
    
    // Accepts nil, String or UIView
    var footers: [Any?]? {
        willSet {
            let sectionsCnt = data?.count ?? 0
            let footersCnt = newValue?.count ?? sectionsCnt
            assert(sectionsCnt == footersCnt, "TableViewHandler: Number of sections in data does not match with number of footers. Use nil for every empty footer.")
        }
    }
    
    // Editing
    var allowEditing = false
    var allowMoving = false
    var editActions: [[[UITableViewRowAction]?]?]?
    
    // Callback closures
    var didSelectCell: ((IndexPath)->())?
    var didDeleteCell: ((IndexPath)->())?
    var didInsertCell: ((IndexPath)->())?
    var didMoveCell: ((IndexPath, IndexPath)->())?
    
    init(with table: UITableView) {
        self.tableView = table
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func beginEditing(_ animated: Bool = true) {
        tableView.setEditing(true, animated: animated)
    }
    
    func endEditing(_ animated: Bool = true) {
        tableView.setEditing(false, animated: animated)
    }
    
    func insert(item: Any, at indexPath: IndexPath) throws {
        try _insert(item: item, at: indexPath)
        tableView.insertRows(at: [indexPath], with: .automatic)
        didInsertCell?(indexPath)
    }
    
    func delete(at indexPath: IndexPath) throws {
        try _delete(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        didDeleteCell?(indexPath)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let section = data?[indexPath.section] {
            let cellData = section[indexPath.row]
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T {
                cell.configure(with: cellData)
                return cell as! UITableViewCell
            }
        }
        fatalError("TableViewHandler: Can't get data for cell of \(T.self) type")
    }
    
    // MARK: - Headers and footers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers?[section] as? String
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return footers?[section] as? String
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headers?[section] as? UIView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footers?[section] as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCell?(indexPath)
    }
    
    // MARK: - UITableViewDelegate - Edit actions mode
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let actionExists = (editActions?[indexPath.section]?[indexPath.row]) != nil
        return actionExists || allowEditing
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return editActions?[indexPath.section]?[indexPath.row]
    }
    
    // MARK: - UITableViewDelegate - Edit mode
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            try? _delete(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            didDeleteCell?(indexPath)
        case .insert:
            break
        default:
            break
        }
    }
    
    private func _delete(at indexPath: IndexPath) throws {
        guard let data = data else {
            throw TableHandlerError.noData
        }
        
        let sIdx = indexPath.section
        guard sIdx >= 0 && sIdx < data.count else {
            throw TableHandlerError.invalidSection(sIdx)
        }
        
        let section = data[sIdx]
        let rIdx = indexPath.row
        guard rIdx >= 0 && rIdx < section.count else {
            throw TableHandlerError.invalidIndex(indexPath)
        }
        
        var edited = section
        edited.remove(at: indexPath.row)
        
        self.data?.remove(at: indexPath.section)
        self.data?.insert(edited, at: indexPath.section)
    }
    
    private func _insert(item: Any, at indexPath: IndexPath) throws {
        guard let data = data else {
            throw TableHandlerError.noData
        }
        
        let sIdx = indexPath.section
        guard sIdx >= 0 && sIdx < data.count else {
            throw TableHandlerError.invalidSection(sIdx)
        }
        
        let section = data[sIdx]
        let rIdx = indexPath.row
        guard rIdx >= 0 && rIdx < section.count + 1 else {
            throw TableHandlerError.invalidIndex(indexPath)
        }
        
        var edited = section
        edited.insert(item, at: indexPath.row)
        
        self.data?.remove(at: indexPath.section)
        self.data?.insert(edited, at: indexPath.section)
    }
    
    // MARK: - UITableViewDelegate - Move mode
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return allowMoving
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let item = data?[sourceIndexPath.section][sourceIndexPath.row] {
            try? _delete(at: sourceIndexPath)
            try? _insert(item: item, at: destinationIndexPath)
            didMoveCell?(sourceIndexPath, destinationIndexPath)
        }
    }
}
