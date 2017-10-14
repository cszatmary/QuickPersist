//    Copyright (c) 2017 Christopher Szatmary <cs@christopherszatmary.com>
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.

import RealmSwift

/// Provides an interface for performing various actions on a realm during a write transaction. This type should only every be used during a write call on a RealmOperator.
public struct WriteTransaction {
    private let realm: Realm
    
    /// Creates a new WriteTransaction with the given Realm.
    public init(realm: Realm) {
        self.realm = realm
    }
    
    /// Adds or updates an existing Persistable type into the Realm.
    /// - parameter value: The value to be added to the realm.
    /// - parameter update: If true, the Realm will try to find a value with the same primary key and update it. Otherwise, the value will be added.
    public func add<T: Persistable>(_ value: T, update: Bool) throws {
        realm.add(try value.container(), update: update)
    }
    
    /// Adds or updates an existing sequence of Persistable types into the Realm.
    /// - parameter values: The sequence of values to be added to the realm.
    /// - parameter update: If true, the Realm will try to find values with the same primary keys and update them. Otherwise, the values will be added.
    public func add<S: Sequence>(_ values: S, update: Bool) throws where S.Element: Persistable {
        try values.forEach { try add($0, update: update) }
    }
    
    /// Deletes a Persistable type from the Realm.
    /// - parameter value: The value to be deleted from the realm.
    public func delete<T: Persistable>(_ value: T) throws {
        guard let container = realm.object(ofType: QPContainer.self, forPrimaryKey: value.primaryKey) else { throw QPError.unableToDelete }
        realm.delete(container)
    }
    
    /// Deletes a sequence of Persistable types from the Realm.
    /// - parameter values: The sequence of values to be deleted from the realm.
    public func delete<S: Sequence>(_ values: S) throws where S.Element: Persistable {
        try values.forEach { try delete($0) }
    }
    
    /// Deletes all objects from the Realm.
    public func deleteAll() {
        realm.deleteAll()
    }
}

