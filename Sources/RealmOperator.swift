//
//  RealmOperator.swift
//  CoffeeList
//
//  Created by Christopher Szatmary on 2017-10-05.
//  Copyright © 2017 Christopher Szatmary. All rights reserved.
//

import RealmSwift

struct RealmOperator {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    init() throws {
        try self.init(realm: Realm())
    }
    
    func write(_ block: (WriteTransaction) throws -> Void) throws {
        try realm.write {
            try block(WriteTransaction(realm: realm))
        }
    }
    
    func values<T: Persistable>(type: T.Type) -> FetchedResults<T> {
        let results = realm.objects(Container.self).filter("typeName == %@", T.typeName)
        return FetchedResults(results: results)
    }
    func value<T: Persistable>(type: T.Type, withKey key: String) -> T? {
        guard let container = realm.object(ofType: Container.self, forPrimaryKey: key) else { return nil }
        return try? T.createFrom(realmContainer: container)
    }
}
