import UIKit

class Pet {
    let type: String
    let age: Int
    
    init(type: String, age: Int) {
        self.type = type
        self.age = age
    }
}

var pets = [
    Pet(type: "dog", age: 5),
    Pet(type: "cat", age: 3),
    Pet(type: "sheep", age: 1),
    Pet(type: "pig", age: 2),
    Pet(type: "cat", age: 3),
]

pets.forEach { p in
    print(p.type)
}

let cc = pets.contains { $0.type == "cat" }
cc

let firstIndex = pets.firstIndex { $0.age == 3 }
firstIndex

let lastIndex = pets.lastIndex { $0.age == 3 }
lastIndex

let sortArr = pets.sorted { $0.age < $1.age }
sortArr

let arr1 = pets.prefix { $0.age > 3 }
arr1

let arr2 = pets.drop { $0.age > 3 }
arr2


let line = "BLANCHE:   I don't want realism. I want magic!"

let wordArr = line.split(whereSeparator: { $0 == " " })
wordArr
