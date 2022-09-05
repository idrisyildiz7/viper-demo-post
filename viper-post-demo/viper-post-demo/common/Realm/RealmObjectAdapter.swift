//
//  RealmObjectAdapter.swift
//  viper demo
//
//  Created by İdris Yıldız on 11/23/17.
//  Copyright © 2022 gidysoft All rights reserved.
//

import RealmSwift

class RealmObjectAdapter<T: Object> {
    
    func objects() -> Results<T>? {
        return try? Realm().objects(T.self)
    }
    
    @discardableResult func create(_ value: [String: Any]? = nil) throws -> T {
        let object = T()
        
        if let value = value {
            object.setValuesForKeys(value)
        }
        
        try add(object)
        return object
    }
    
    func add(_ object: T) throws {
        try RealmService.add(object)
    }
    
    func edit(_ object: T, set value: [String: Any]) throws {
        let realm = try Realm()
        try realm.safeWrite {
            object.setValuesForKeys(value)
        }
    }
    
    func remove(_ object: T) throws {
        try RealmService.remove(object)
    }
}
