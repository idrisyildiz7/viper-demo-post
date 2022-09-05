//
//  RealmService.swift
//  AidaApp
//
//  Created by İdris Yıldız on 11/21/17.
//  Copyright © 2022 gidysoft All rights reserved.
//

import RealmSwift

class RealmService {

    static let version: UInt64 = 1
    
    static func configure() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: version, migrationBlock: migrate)
    }

    static func write(_ writeClosure: ()->()) throws {
        let realm = try Realm()
        try realm.safeWrite(writeClosure)
    }

    static func add(_ object: Object) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.add(object)
        }
    }

    static func remove(_ object: Object) throws {
        let realm = try Realm()
        try realm.safeWrite {
            if !object.isInvalidated
            {
               realm.delete(object)
            }
        }
    }

    static func removeAll(of type: Object.Type) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.delete(realm.objects(type))
        }
    }

    static func migrate(migration: Migration, oldVersion: UInt64) {

    }
}

extension Realm {
    func safeWrite( _ writeClosure: () -> ()) throws {
        if isInWriteTransaction {
            writeClosure()
        } else {
            try write { writeClosure() }
        }
    }
}
