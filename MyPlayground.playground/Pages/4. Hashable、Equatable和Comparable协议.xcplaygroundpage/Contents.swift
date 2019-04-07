//: [Previous](@previous)

import Foundation

struct Pet: Equatable {
    let name: String
    let age: Int
}


let p1 = Pet(name: "Cat", age: 2)
let p2 = Pet(name: "Dog", age: 3)

p1 == p2


enum Season: Equatable {
    case spring(mouth: String)
    case summer
    case autumn(mouth: String)
    case winter
}

let season1 = Season.spring(mouth: "4")
let season2 = Season.autumn(mouth: "4")

season1 == season2


class Animal: Equatable, Hashable, Comparable {
    
    static func < (lhs: Animal, rhs: Animal) -> Bool {
        if lhs.age < rhs.age{
            return true
        }else {
            return false
        }
    }
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        if lhs.type == rhs.type && lhs.age == rhs.age{
            return true
        }else {
            return false
        }
    }
    
    var hashValue: Int {
        return self.type.hashValue ^ self.age.hashValue
        
    }
    
    let type: String
    let age: Int
    
    init(type: String, age: Int) {
        self.type = type
        self.age = age
    }
}


let a1 = Animal(type: "Cat", age: 3)
let a2 = Animal(type: "Cat", age: 4)
let a3 = Animal(type: "Cat", age: 1)
let a4 = Animal(type: "Cat", age: 6)


a1 == a2

a1.hashValue
a2.hashValue


let animals = [a1, a2, a3, a4]


let b = a1 < a2
let sortedAnimals = animals.sorted(by: <)
sortedAnimals
