import UIKit

// map的实现过程
extension Sequence {
    
    // 可以将一些公共功能注释为@inlinable,给编译器提供优化跨模块边界的泛型代码的选项
    @inlinable
    public func customMap<T>(
        _ transform: (Element) throws -> T
        ) rethrows -> [T] {
        let initialCapacity = underestimatedCount
        var result = ContiguousArray<T>()
        
        // 因为知道当前元素个数,所以一次性为数组申请完内存,避免重复申请
        result.reserveCapacity(initialCapacity)
        
        // 获取所有元素
        var iterator = self.makeIterator()
        
        // 将元素通过参数函数处理后添加到数组中
        for _ in 0..<initialCapacity {
            result.append(try transform(iterator.next()!))
        }
        // 如果还有剩下的元素,添加进去
        while let element = iterator.next() {
            result.append(try transform(element))
        }
        return Array(result)
    }
}


let arr: [Int] = [2, 4, 6, 7, 11, 13, 17]
let squareArr = arr.customMap { $0 * $0 }
// [4, 16, 36, 49, 121, 169, 289]



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
// 遍历所有元素
pets.forEach { p in
//    print(p.type)
}

// 是否包含满足条件的元素
let cc = pets.contains { $0.type == "cat" }

// 第一次出现满足条件的元素的位置
let firstIndex = pets.firstIndex { $0.age == 3 }
// 1

// 最后一次出现满足条件的元素的位置
let lastIndex = pets.lastIndex { $0.age == 3 }
// 4

// 根据年龄从大到小进行排序
let sortArr = pets.sorted { $0.age < $1.age }

// 获取age大于3的元素
let arr1 = pets.prefix { $0.age > 3 }
// [{type "dog", age 5}]

// 获取age大于3的取反的元素
let arr2 = pets.drop { $0.age > 3 }
// [{type "cat", age 3}, {type "sheep", age 1}, {type "pig", age 2}, {type "cat", age 3}]


let line = "BLANCHE:   I don't want realism. I want magic!"
// 将字符串转化为数组
let wordArr = line.split(whereSeparator: { $0 == " " })
// ["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]
