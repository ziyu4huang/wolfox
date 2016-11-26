//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


struct User {
    var Id: Int
    var age: Int
}

var user = User(Id: 10, age: 10)

let userPointer = withUnsafePointer(to: &user, {$0})

print(userPointer.pointee)

//get user ID pointer

//print(UnsafeMutablePointer)
var userIDPointer = unsafeBitCast(userPointer, to: UnsafeMutablePointer.self)



//print(userIDPointer)


//: [Next](@next)
