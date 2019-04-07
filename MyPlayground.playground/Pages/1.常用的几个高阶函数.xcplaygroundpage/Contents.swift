//: [Previous](@previous)

import Foundation

let intArr = [13, 45, 27, 80, 22, 53]

let sortOneArr = intArr.sorted { (a: Int, b: Int) -> Bool in
    return a < b
}
sortOneArr

let sortTwoArr = intArr.sorted { (a: Int, b: Int) in
    return a < b
}
sortTwoArr

let sortThreeArr = intArr.sorted { (a, b) in
    return a < b
}
sortThreeArr

let sortFourArr = intArr.sorted {
    return $0 < $1
}
sortFourArr

let sortFiveArr = intArr.sorted {
    $0 < $1
}
sortFiveArr

let sortSixArr = intArr.sorted(by: <)
sortSixArr


let mapArr = intArr.map { $0 * $0 }
mapArr

let optionalArr = [nil, 4, 12, 7, Optional(3), 9]
let compactMapArr = optionalArr.compactMap { $0 }
compactMapArr

let evenArr = intArr.filter { $0 % 2 == 0 }
evenArr

let stringArr = ["1", "2", "3", "*", "a"]
let allStr = stringArr.reduce("") { $0 + $1 }
allStr


let chainArr = [4, 3, 5, 8, 6, 2, 4, 7]
let resultArr = chainArr.filter {
        $0 % 2 == 0
    }.map {
        $0 * $0
    }.reduce(0) {
        $0 + $1
}
resultArr
