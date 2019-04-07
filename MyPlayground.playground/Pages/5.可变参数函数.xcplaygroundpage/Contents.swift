//: [Previous](@previous)

import Foundation


/// 求和
// 常用的姿势
let sum2 = [2, 3, 4, 5, 6, 7, 8, 9].reduce(0) { $0 + $1 }
sum2

// 使用可变参数函数
sum(values: 2, 3, 4, 5, 6, 7, 8, 9)

// 可变参数的类型是个数组
func sum(values:Int...) -> Int {
    var result = 0
    values.forEach({ a in
        result += a
    })
    return result
}


