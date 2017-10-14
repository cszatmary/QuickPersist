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

/// A QPContainer allows any type that is JSON encodable to be persisted to a Realm.
public class QPContainer: Object {
    /// JSON encoded data that should be persisted to a Realm.
    @objc public dynamic var data = Data()
    
    /// The name of the type that the encoded data is. Used for retrieving all values.
    @objc public dynamic var typeName = ""
    
    /// The unique identifier for the data. This property is used as the primay key.
    @objc public dynamic var id = ""
    
    /// Creates a new QPContainer instance from the given data.
    /// - parameter data: The encode json data to be persisted.
    /// - parameter typeName: The type name of the data.
    /// - parameter id: The unique identifier for the data so it can be retreived later.
    public convenience init(data: Data, typeName: String, id: String) {
        self.init()
        self.data = data
        self.typeName = typeName
        self.id = id
    }
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

