# SwiftTips (๑•̀ㅂ•́)و✧
记录iOS开发中的一些知识点  

[![Language: Swift 4.2](https://img.shields.io/badge/language-swift4.2-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 12](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)


[1.常用的几个高阶函数](#1)  
[2.高阶函数扩展](#2)  
[3.优雅的判断多个值中是否包含某一个值](#3)  
[4.Hashable、Equatable和Comparable协议](#4)  
[5.可变参数函数](#5)  
[6.where关键字](#6)  
[7.switch中判断枚举类型,尽量避免使用default](#7)  
 

<h2 id="1">1.常用的几个高阶函数</h2>  

函数式编程在swift中有着广泛的应用,下面列出了几个常用的高阶函数.
#### 1. sorted
常用来对数组进行排序.顺便感受下函数式编程的多种姿势.

##### 1. 使用sort进行排序,不省略任何类型

```swift
let intArr = [13, 45, 27, 80, 22, 53]

let sortOneArr = intArr.sorted { (a: Int, b: Int) -> Bool in
    return a < b
}
// [13, 22, 27, 45, 53, 80]
```
##### 2. 编译器可以自动推断出返回类型,所以可以省略

```swift
let sortTwoArr = intArr.sorted { (a: Int, b: Int) in
    return a < b
}
// [13, 22, 27, 45, 53, 80]
```

##### 3. 编译器可以自动推断出参数类型,所以可以省略

```swift
let sortThreeArr = intArr.sorted { (a, b) in
    return a < b
}
// [13, 22, 27, 45, 53, 80]
```

##### 4. 编译器可以自动推断出参数个数,所以可以用$0,$1替代

```swift
let sortFourArr = intArr.sorted {
    return $0 < $1
}
// [13, 22, 27, 45, 53, 80]
```

##### 5. 如果闭包中的函数体只有一行,且需要有返回值,return可以省略

```swift
let sortFiveArr = intArr.sorted {
    $0 < $1
}
// [13, 22, 27, 45, 53, 80]
```

##### 6. 最简化: 可以直接传入函数`<`

```swift
let sortSixArr = intArr.sorted(by: <)
// [13, 22, 27, 45, 53, 80]
```

#### 2. map和compactMap
##### 1. map: 对数组中每个元素做一次处理.

```swift
let mapArr = intArr.map { $0 * $0 }
// [169, 2025, 729, 6400, 484, 2809]
```
##### 2. compactMap: 和map类似,但可以过滤掉nil,还可以对可选类型进行解包.

```swift
let optionalArr = [nil, 4, 12, 7, Optional(3), 9]
let compactMapArr = optionalArr.compactMap { $0 }
// [4, 12, 7, 3, 9]
```

#### 3. filter: 将符合条件的元素重新组合成一个数组

```swift
let evenArr = intArr.filter { $0 % 2 == 0 }
// [80, 22]
```

#### 4. reduce: 将数组中的元素合并成一个

```swift
// 组合成一个字符串
let stringArr = ["1", "2", "3", "*", "a"]
let allStr = stringArr.reduce("") { $0 + $1 }
// 123*a

// 求和
let sum = intArr.reduce(0) { $0 + $1 }
// 240
```
#### 5. 高阶函数可以进行链式调用.比如,求一个数组中偶数的平方和

```swift
let chainArr = [4, 3, 5, 8, 6, 2, 4, 7]

let resultArr = chainArr.filter {
                            $0 % 2 == 0
                        }.map {
                            $0 * $0
                        }.reduce(0) {
                            $0 + $1
                        }
// 136
```


<h2 id="2">2.高阶函数扩展</h2> 


#### 1. map函数的实现原理

```swift
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

```
map的实现无非就是创建一个空数组,通过for循环遍历将每个元素通过传入的函数处理后添加到空数组中,只不过swift的实现更加高效一点.

关于其余相关高阶函数的实现:[Sequence.swift
](https://github.com/apple/swift/blob/swift-4.2-branch/stdlib/public/core/Sequence.swift)

#### 2. 关于数组中用到的其他的一些高阶函数

```swift
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
```
###### 1. 遍历所有元素
```swift         
pets.forEach { p in
   print(p.type)
}
```
###### 2. 是否包含满足条件的元素
```swift
let cc = pets.contains { $0.type == "cat" }
```
###### 3. 第一次出现满足条件的元素的位置
```swift
let firstIndex = pets.firstIndex { $0.age == 3 }
// 1
```
###### 4. 最后一次出现满足条件的元素的位置
```swift
let lastIndex = pets.lastIndex { $0.age == 3 }
// 4
```
###### 5. 根据年龄从大到小进行排序
```swift
let sortArr = pets.sorted { $0.age < $1.age }
```
###### 6. 获取age大于3的元素
```swift
let arr1 = pets.prefix { $0.age > 3 }
// [{type "dog", age 5}]
```
###### 7. 获取age大于3的取反的元素
```swift
let arr2 = pets.drop { $0.age > 3 }
// [{type "cat", age 3}, {type "sheep", age 1}, {type "pig", age 2}, {type "cat", age 3}]

```
###### 8. 将字符串转化为数组
```swift
let line = "BLANCHE:   I don't want realism. I want magic!"

let wordArr = line.split(whereSeparator: { $0 == " " })
// ["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]
```

<h2 id="3">3.优雅的判断多个值中是否包含某一个值</h2>  

我们最常用的方式

```swift
let string = "One"

if string == "One" || string == "Two" || string == "Three" {
    print("One")
}
```
这种方式是可以,但可阅读性不够,那有啥好的方式呢?  
#### 1. 我们可以利用`contains`:

```swift
if ["One", "Two", "Three"].contains(where: { $0 == "One"}) {
	print("One")
}
```
#### 2. 自己手动实现一个`any`  

##### 使用:
```swift

if string == any(of: "One", "Two", "Three") {
    print("One")
}

```

##### 实现:

```swift
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
```
这样做的前提是any中传入的值需要实现`Equatable`协议.


<h2 id="4">4. Hashable、Equatable和Comparable协议</h2>  

#### 1. Hashable  
实现Hashable协议的方法后我们可以根据`hashValue`方法来获取该对象的哈希值.  
字典中的value的存储就是根据key的`hashValue`,所以所有字典中的key都要实现Hashable协议.

```swift
class Animal: Hashable {
    
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
a1.hashValue
// 哈希值
```
#### 2. Equatable协议
实现Equatable协议后,就可以用`==`符号来判断两个对象是否相等了.

```swift
class Animal: Equatable, Hashable {
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        if lhs.type == rhs.type && lhs.age == rhs.age{
            return true
        }else {
            return false
        }
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

a1 == a2
// false
```
#### 3. Comparable协议
基于Equatable基础上的Comparable类型,实现相关的方法后可以使用`<`、`<=`、`>=`、`>` 等符号进行比较.

```swift
class Animal: Comparable {
    // 只根据年龄选项判断
    static func < (lhs: Animal, rhs: Animal) -> Bool {
        if lhs.age < rhs.age{
            return true
        }else {
            return false
        }
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

// 按照年龄从大到小排序
let sortedAnimals = [a1, a2, a3, a4].sorted(by: <)
```
在日常开发中会涉及到大量对自定义对象的比较操作,所以`Comparable`协议的用途还是比较广泛的.

`Comparable`协议除了应用在类上,还可以用在**结构体**和**枚举**上.

 <h2 id="5">5.可变参数函数</h2>  
在定义函数的时候,如果参数的个数不确定时,需要使用可变参数函数.举个例子,对数组的求和.

```swift
// 常用的姿势
[2, 3, 4, 5, 6, 7, 8, 9].reduce(0) { $0 + $1 }
// 44

// 使用可变参数函数
sum(values: 2, 3, 4, 5, 6, 7, 8, 9)
// 44

// 可变参数的类型是个数组
func sum(values:Int...) -> Int {
    var result = 0
    values.forEach({ a in
        result += a
    })
    return result
}

```

应用: 

```swift

// 给UIView添加子控件
let view = UIView()
let label = UILabel()
let button = UIButton()
view.add(view, label, button)

extension UIView {
    /// 同时添加多个子控件
    ///
    /// - Parameter subviews: 单个或多个子控件
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}

```

<h2 id="6">6.where关键字</h2>   

where的主要作用是用来做限定.  

#### 1. `for`循环的时候用来做条件判断

```swift
// 只遍历数组中的偶数
let arr = [11, 12, 13, 14, 15, 16, 17, 18]
for num in arr where num % 2 == 0 {
    // 12 14 16 18
}
```

#### 2. 在`try` `catch`的时候做条件判断

```swift
enum ExceptionError:Error{
    case httpCode(Int)
}

func throwError() throws {
    throw ExceptionError.httpCode(500)
}

do{
    try throwError()
// 通过where添加限定条件
}catch ExceptionError.httpCode(let httpCode) where httpCode >= 500{
    print("server error")
}catch {
    print("other error")
}
```  

#### 3. switch语句做限定条件

```swift
let student:(name:String, score:Int) = ("小明", 59)
switch student {
case let (_,score) where score < 60:
    print("不及格")
default:
    print("及格")
}
```  

#### 4. 限定泛型需要遵守的协议

```swift
//第一种写法
func genericFunctionA<S>(str:S) where S:ExpressibleByStringLiteral{
    print(str)
}
//第二种写法
func genericFunctionB<S:ExpressibleByStringLiteral>(str:S){
    print(str)
}
```
#### 5. 为指定的类添加对应的协议扩展

```swift
// 为Numeric在Sequence中添加一个求和扩展方法
extension Sequence where Element: Numeric {
    var sum: Element {
        var result: Element = 0
        for item  in self {
            result += item
        }
        return result
    }
}

print([1,2,3,4].sum) // 10
```

参考: [Swift where 关键字](https://www.jianshu.com/p/1546594b856b)  


<h2 id="7">7.switch中判断枚举类型,尽量避免使用default</h2> 

通过`switch`语句来判断枚举类型,不使用`default`,如果后期添加新的枚举类型,而忘记在`switch`中处理,会报错,这样可以提高代码的健壮性.

```swift
enum State {        
    case loggedIn
    case loggedOut
    case startUI
}
    
func handle(_ state: State) {
    switch state {
    case .loggedIn:
         showMainUI()
    case .loggedOut:
        showLoginUI()
        
        // Compiler error: Switch must be exhaustive
    }
}

```