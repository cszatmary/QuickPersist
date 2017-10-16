# QuickPersist

[![Language Swift](https://img.shields.io/badge/Language-Swift%204.0-orange.svg?style=flat)](https://swift.org)
[![Version](https://img.shields.io/cocoapods/v/QuickPersist.svg?style=flat)](http://cocoapods.org/pods/QuickPersist)
[![License](https://img.shields.io/cocoapods/l/QuickPersist.svg?style=flat)](http://cocoapods.org/pods/QuickPersist)
[![Platform](https://img.shields.io/cocoapods/p/QuickPersist.svg?style=flat)](http://cocoapods.org/pods/QuickPersist)

**QuickPersist** provides an easy way to save Swift structs to a Realm database.

## Basic Use

### Persistable
In order to persist a struct to a Realm, the struct must conform to the `Persistable` protocol.
`Persistable` requires conforming types to conform to `Codable`.

`Persistable` requires two properties to be implemented.
* `typeName`:  a `String` that represents the name of the struct.
* `primaryKey`: a `String` value that is a unique identifier for the instance

```swift
struct Person {
    var name: String
    var age: Int
    let id: String
}

extension Person: Persistable {
    static var typeName: String {
        return "Person"
    }
    
    var primaryKey: String {
        return id
    }
}
```
That's it! QuickPersist takes care of the rest. This struct is now ready to be persisted.

### RealmOperator
QuickPersist provides a type called RealmOperator that lets you do basic operations on a Realm that involve Persistable types.

```swift
let op = try! RealmOperator() // Creates a new RealmOperator from the default Realm.
```
Or

```swift
let op = RealmOperator(realm: myCustomRealm) // Creates a new RealmOperator from the given Realm.
```
### WriteTransaction
WriteTransaction provides an interface for interacting with a Realm during a write transaction. It should only every be used inside a RealmOperator write block.

Here's an example of how to save a struct to a Realm:

```swift
let person = Person(name: "John Doe", age: 20, id: UUID().uuidString)

let op = try! RealmOperator()

try! op.write { (writeTransaction) in
    try! writeTransaction.add(person, update: true)
}
```
WriteTransaction takes Persistable instances directly, and performs the necessary actions to save  it to the Realm. No extra work required.

### QPResults
QPResults is a special wrapper over Realm's `Results` that provides an easy way to get persisted values back in their original form.

Here's an example of getting values from a Realm:

```swift
let op = try! RealmOperator()
let results = op.values(ofType: Person.self)
let person = results[0] // Returns an instance of Person.
```

Or if you can get a specific value with an id:
```swift
let person = op.value(ofType: Person.self, withPrimaryKey: id)
```

## Installation

### Requirements
* iOS 8.0+
* macOS 10.9+
* tvOS 9.0+
* watchOS  2.0+
* Swift 4

### CocoaPods

QuickPersist is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QuickPersist', '~> 1.0'
```
**Note:** QuickPersist requires [RealmSwift](https://github.com/realm/realm-cocoa).

## Contributing
Open an issue or submit a pull request.
