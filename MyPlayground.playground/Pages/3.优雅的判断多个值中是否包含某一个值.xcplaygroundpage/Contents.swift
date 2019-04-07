//: [Previous](@previous)

import Foundation

let string = "One"

// 方案1
if string == "One" || string == "Two" || string == "Three" {
    print("One")
}

// 方案2
if ["One", "Two", "Three"].contains(where: { $0 == "One"}) {
    print("One")
}


// 方案3
func any<T: Equatable>(of values: T...) -> EquatableValueSequence<T> {
    return EquatableValueSequence(values: values)
}

struct EquatableValueSequence<T: Equatable> {
    static func ==(lhs: EquatableValueSequence<T>, rhs: T) -> Bool {
        return lhs.values.contains(rhs)
    }
    
    static func ==(lhs: T, rhs: EquatableValueSequence<T>) -> Bool {
        return rhs == lhs
    }
    
    fileprivate let values: [T]
}

if string == any(of: "One", "Two", "Three") {
    print("One")
}
