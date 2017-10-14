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

/// `QPResults` is a collection of Persistable types returned from a query. When an element is accessed it is returned as its original type.
public struct QPResults<T: Persistable> {
    private let results: Results<QPContainer>
    
    /// Creates a new instance from a collection of Realm Results.
    public init(results: Results<QPContainer>) {
        self.results = results
    }
    
    /// Returns the value at the given index.
    public func value(at index: Int) -> T? {
        return try? T.create(fromContainer: results[index])
    }
    
    /// Returns the value at the given index.
    public subscript(index: Int) -> T? {
        return value(at: index)
    }
}

extension QPResults: Collection {
    
    public var startIndex: Int {
        return results.startIndex
    }
    
    public var endIndex: Int {
        return results.endIndex
    }
    
    public func index(after i: Int) -> Int {
        return results.index(after: i)
    }
    
    public var count: Int {
        return results.count
    }
    
    public var isEmpty: Bool {
        return results.isEmpty
    }
}

