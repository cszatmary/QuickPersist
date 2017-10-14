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

import Foundation

/// A type that is able to be saved to a Realm database. Any type conforming to this protocol must also conform to the `Codable` protocol
/// so that it can be converted to and from `JSON`.
public protocol Persistable: Codable {
    /// A string representing the name of the `Persistable` type.
    static var typeName: String { get }
    
    /// The primary key of the instance. This used when retreiving values from a Realm.
    var primaryKey: String { get }
    
    /// Creates an instance of a `Persistable` type from a `QPContainer`.
    /// - parameter container: The container that stores the `JSON` encoded type.
    static func create(fromContainer container: QPContainer) throws -> Self
    
    /// Creates a `QPContainer` from a `Persistable` instance.
    func container() throws -> QPContainer
}

public extension Persistable {
    public static func create(fromContainer container: QPContainer) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: container.data)
    }
    
    public func container() throws -> QPContainer {
        return QPContainer(data: try JSONEncoder().encode(self), typeName: Self.typeName, id: primaryKey)
    }
}

