import UIKit


let intArr = [13, 45, 27, 80, 22, 53]

// 使用sort进行排序,不省略任何类型
let sortOneArr = intArr.sorted { (a: Int, b: Int) -> Bool in
    return a < b
}
// [13, 22, 27, 45, 53, 80]



// 编译器可以自动推断出返回类型,所以可以省略
let sortTwoArr = intArr.sorted { (a: Int, b: Int) in
    return a < b
}
// [13, 22, 27, 45, 53, 80]



// 编译器可以自动推断出参数类型,所以可以省略
let sortThreeArr = intArr.sorted { (a, b) in
    return a < b
}
// [13, 22, 27, 45, 53, 80]


// 编译器可以自动推断出参数个数,所以可以用$0,$1替代
let sortFourArr = intArr.sorted {
    return $0 < $1
}
// [13, 22, 27, 45, 53, 80]


// 如果闭包中的函数体只有一行,且需要有返回值,return可以省略
let sortFiveArr = intArr.sorted {
    $0 < $1
}
// [13, 22, 27, 45, 53, 80]


// 最简化: 可以直接传入函数`<`
let sortSixArr = intArr.sorted(by: <)
// [13, 22, 27, 45, 53, 80]



let mapArr = intArr.map { $0 * $0 }
// [169, 2025, 729, 6400, 484, 2809]


let optionalArr = [nil, 4, 12, 7, Optional(3), 9]
let compactMapArr = optionalArr.compactMap { $0 }
// [4, 12, 7, 3, 9]


let evenArr = intArr.filter { $0 % 2 == 0 }
// [80, 22]


let stringArr = ["1", "2", "3", "*", "a"]
let allStr = stringArr.reduce("") { $0 + $1 }
// 123*a

let sum = intArr.reduce(0) { $0 + $1 }
// 240



let chainArr = [4, 3, 5, 8, 6, 2, 4, 7]

let resultArr = chainArr.filter {
                            $0 % 2 == 0
                        }.map {
                            $0 * $0
                        }.reduce(0) {
                            $0 + $1
                        }
// 136
