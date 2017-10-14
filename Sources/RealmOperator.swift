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

/// Provides an interface for performing various actions on a realm.
public struct RealmOperator {
    private let realm: Realm
    
    /// Creates a new RealmOperator with the given Realm.
    public init(realm: Realm) {
        self.realm = realm
    }
    
    /// Creates a new RealmOperator from the default Realm.
    /// - throws: If the default Realm can't be constructed.
    public init() throws {
        try self.init(realm: Realm())
    }
    
    /// Performs actions on the Realm within a write transaction.
    /// - parameter block: The actions to perform.
    public func write(_ block: (WriteTransaction) throws -> Void) throws {
        try realm.write {
            try block(WriteTransaction(realm: realm))
        }
    }
    
    /// Returns all values of the given type stored in the Realm.
    /// - parameter ofType: The type of the values to be returned.
    /// - returns: A `QPResults` containing all the values.
    public func values<T: Persistable>(ofType: T.Type) -> QPResults<T> {
        let results = realm.objects(QPContainer.self).filter("typeName == %@", T.typeName)
        return QPResults(results: results)
    }
    
    /// Returns a value with the given primary key stored in the Realm.
    /// - parameter ofType: The type of the value to be returned.
    /// - parameter key: The primary key of the value.
    /// - returns: The value or `nil` if no instance with the given primary key exists.
    public func value<T: Persistable>(ofType: T.Type, withPrimaryKey key: String) -> T? {
        guard let container = realm.object(ofType: QPContainer.self, forPrimaryKey: key) else { return nil }
        return try? T.create(fromContainer: container)
    }
}

