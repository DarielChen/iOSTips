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
[8.iOS9之后全局动态修改StatusBar样式](#8)  
[9.使用面向协议实现app的主题功能](#9)  
[10.swift中多继承的实现](#10)  
[11.华丽的TableView刷新动效](#11)  
[12.实现一个不基于Runtime的KVO](#12)  
[13.实现多重代理](#13)   
[14.自动检查控制器是否被销毁](#14)  
[15.向控制器中注入代码](#15)  
[16.给Extension添加存储属性](#16)  
[17.用闭包实现按钮的链式点击事件](#17)  
[18.用闭包实现手势的链式监听事件](#18)  
[19.用闭包实现通知的监听事件](#19)  
[20.使用命令模式给AppDelegate解耦](#20)  
[21.常见的编译器诊断指令](#21)


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

#### 6. 为某些高阶函数的限定条件

```swift
let names = ["Joan", "John", "Jack"]
let firstJname = names.first(where: { (name) -> Bool in
    return name.first == "J"
})
// "Joan"
let fruits = ["Banana", "Apple", "Kiwi"]
let containsBanana = fruits.contains(where: { (fruit) in
    return fruit == "Banana"
})
// true
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


 <h2 id="8">8.iOS9之后全局动态修改StatusBar样式</h2>  
 
#### 1. 局部修改StatusBar样式
最常用的方法是通过控制器来修改`StatusBar`样式

```swift
override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
}
```
注意:如果当前控制器有导航控制器,需要在导航控制器中这样设置(如下代码),不然不起作用.

```swift
override var preferredStatusBarStyle: UIStatusBarStyle {
    return topViewController?.preferredStatusBarStyle ?? .default
}
```
这样做的好处是,可以针对不同的控制器设置不同的`StatusBar`样式,但有时往往会多此一举,略嫌麻烦,那如何全局统一处理呢?

#### 2. iOS9之前全局修改StatusBar样式
iOS9之前的做法比较简单,在`plist`文件中设置`View controller-based status bar appearance`为`NO`.  

在需要设置的地方添加

```swift
UIApplication.shared.setStatusBarStyle(.default, animated: true)
```
这样全局设置`StatusBar`样式就可以了,但iOS9之后`setStatusBarStyle`方法被废弃了,苹果推荐使用`preferredStatusBarStyle`,也就是上面那种方法.
#### 3. iOS9之后全局修改StatusBar样式
我们可以用`UIAppearance`和导航栏的`barStyle`去全局设置`StatusBar`的样式.

- `UIAppearance`属性可以做到全局修改样式.
- 导航栏的`barStyle`决定了`NavigationBar`的外观,而`barStyle`属性改变会联动到`StatusBar`的样式.
	1. 当`barStyle = .default`,表示导航栏的为默认样式,`StatusBar`的样式为了和导航栏区分,就会变成**黑色**.
	2. 当`barStyle = .black`,表示导航栏的颜色为深黑色,`StatusBar`的样式为了和导航栏区分,就会变成**白色**.

	这个有点绕,总之就是`StatusBar`的样式和导航栏的样式反着来.
	
具体实现:

```swift
@IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
    switch sender.selectedSegmentIndex {
    case 0:
    	 // StatusBar为黑色,导航栏颜色为白色
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().barTintColor = UIColor.white
    default:
    	 // StatusBar为白色,导航栏颜色为深色
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().barTintColor = UIColor.darkNight
    }
    
    // 刷新window下的子控件
    UIApplication.shared.windows.forEach {
        $0.reload()
    }
}

public extension UIWindow {
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
```

<img src="http://pcb5zz9k5.bkt.clouddn.com/changeStatusBarStyle2.gif" width=250>


<h2 id="9">9.使用面向协议实现app的主题功能</h2>

#### 1. `UIAppearance`修改全局样式

做为修改全局样式的`UIAppearance`用起来还是很方便的,比如要修改所有`UILabel`的文字颜色.

```swift
UILabel.appearance().textColor = labelColor
```
又或者我们只想修改某个`CustomView`层级下的子控件`UILabel`

```swift
UILabel.appearance(whenContainedInInstancesOf: [CustomView.self]).textColor = labelColor
```

#### 2. 主题协议,以及实现  

定义好协议中需要实现的属性和方法

```swift
protocol Theme {
    
    // 自定义的颜色
    var tint: UIColor { get }
    // 定义导航栏的样式,为了联动状态栏(具体见第9小点)
    var barStyle: UIBarStyle { get }
    
    var labelColor: UIColor { get }
    var labelSelectedColor: UIColor { get }
    
    var backgroundColor: UIColor { get }
    var separatorColor: UIColor { get }
    var selectedColor: UIColor { get }
    
    // 设置主题样式
    func apply(for application: UIApplication)
    
    // 对特定主题样式进行扩展
    func extend()
}
```
对协议添加`extension`,这样做的好处是,如果有多个结构体或类实现了协议,而每个结构体或类需要实现相同的方法,这些方法就可以统一放到`extension`中处理,大大提高了代码的复用率.  
如果结构体或类有着相同的方法实现,那么结构体或类的实现会**覆盖**掉协议的`extension`中的实现.

```swift
extension Theme {
    
    func apply(for application: UIApplication) {
        application.keyWindow?.tintColor = tint
        
        
        UITabBar.appearance().with {
            $0.barTintColor = tint
            $0.tintColor = labelColor
        }
        
        UITabBarItem.appearance().with {
            $0.setTitleTextAttributes([.foregroundColor : labelColor], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor : labelSelectedColor], for: .selected)
        }
        

        UINavigationBar.appearance().with {
            $0.barStyle = barStyle
            $0.tintColor = tint
            $0.barTintColor = tint
            $0.titleTextAttributes = [.foregroundColor : labelColor]
        }
        
       UITextView.appearance().with {
            $0.backgroundColor = selectedColor
            $0.tintColor = tint
            $0.textColor = labelColor
        }
        
        extend()
        
        application.windows.forEach { $0.reload() }
    }
    
    // ... 其余相关UIAppearance的设置
    
    
    // 如果某些属性需要在某些主题下定制,可在遵守协议的类或结构体下重写
    func extend() {
        // 在主题中实现相关定制功能
    }
}

```

#### 3. 对主题某些样式的自定义
Demo中白色主题的`UISegmentedControl`需要设置特定的颜色,我们可以在`LightTheme`的`extension`中重写`extend()`方法.

```swift
extension LightTheme {
    
    // 需要自定义的部分写在这边
    func extend() {
        UISegmentedControl.appearance().with {
            $0.tintColor = UIColor.darkText
            $0.setTitleTextAttributes([.foregroundColor : labelColor], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        }
        UISlider.appearance().tintColor = UIColor.darkText
    }
}

```

#### 4. 主题切换
在设置完`UIAppearance`后需要对所有的控件进行刷新,这个操作放在`apply`方法中.具体实现

```swift
public extension UIWindow {
    /// 刷新所有子控件
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
```

[示例Demo](https://github.com/DarielChen/SwiftTips/tree/master/Demo/9.%E4%BD%BF%E7%94%A8%E9%9D%A2%E5%90%91%E5%8D%8F%E8%AE%AE%E5%AE%9E%E7%8E%B0app%E7%9A%84%E4%B8%BB%E9%A2%98%E5%8A%9F%E8%83%BD)  
[实现效果](http://pcb5zz9k5.bkt.clouddn.com/themeDemo.gif)


<h2 id="10">10.swift中多继承的实现</h2>  

#### 1. 实现过程
swift本身并不支持多继承,但我们可以根据已有的API去实现. 
 
swift中的类可以遵守多个协议,但是只可以继承一个类,而值类型(结构体和枚举)只能遵守单个或多个协议,不能做继承操作.  

多继承的实现:**协议的方法可以在该协议的`extension`中实现**

```swift
protocol Behavior {
    func run()
}
extension Behavior {
    func run() {
        print("Running...")
    }
}

struct Dog: Behavior {}

let myDog = Dog()
myDog.run() // Running...
```
无论是结构体还是类还是枚举都可以遵守多个协议,所以多继承就这么做到了.

#### 2. 通过多继承为`UIView`扩展方法

```swift
// MARK: - 闪烁功能
protocol Blinkable {
    func blink()
}
extension Blinkable where Self: UIView {
    func blink() {
        alpha = 1
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [.repeat, .autoreverse],
            animations: {
                self.alpha = 0
        })
    }
}

// MARK: - 放大和缩小
protocol Scalable {
    func scale()
}
extension Scalable where Self: UIView {
    func scale() {
        transform = .identity
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [.repeat, .autoreverse],
            animations: {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
    }
}

// MARK: - 添加圆角
protocol CornersRoundable {
    func roundCorners()
}
extension CornersRoundable where Self: UIView {
    func roundCorners() {
        layer.cornerRadius = bounds.width * 0.1
        layer.masksToBounds = true
    }
}

extension UIView: Scalable, Blinkable, CornersRoundable {}

 cyanView.blink()
 cyanView.scale()
 cyanView.roundCorners()
```

<img src="http://pcb5zz9k5.bkt.clouddn.com/blink_scale_corner.gif" width=250>


#### 3. 多继承钻石问题(Diamond Problem),及解决办法
请看下面代码

```swift
protocol ProtocolA {
    func method()
}

extension ProtocolA {
    func method() {
        print("Method from ProtocolA")
    }
}

protocol ProtocolB {
    func method()
}

extension ProtocolB {
    func method() {
        print("Method from ProtocolB")
    }
}

class MyClass: ProtocolA, ProtocolB {}
```
此时`ProtocolA`和`ProtocolB`都有一个默认的实现方法`method()`,由于编译器不知道继承过来的`method()`方法是哪个,就会报错.
> 💎钻石问题,当某一个类或值类型在继承图谱中有多条路径时就会发生.

解决方法:  
	1. 在目标值类型或类中重写那个发生冲突的方法`method()`.  
	2. 直接修改协议中重复的方法

相对来时第二种方法会好一点,所以多继承要注意,尽量避免多继承的协议中的方法的重复.


<h2 id="11">11.华丽的TableView刷新动效</h2>  

[先看效果](http://pcb5zz9k5.bkt.clouddn.com/TableViewRefreshAnimation2.gif
)(由于这个页面的内容有点多,我尽量不放加载比较耗时的文件)

#### 1. 简单的实现
我们都知道`TableView`的刷新动效是设置在`tableView(_:,willDisplay:,forRowAt:)`这个方法中的.

```swift
override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    cell.alpha = 0
    UIView.animate(
        withDuration: 0.5,
        delay: 0.05 * Double(indexPath.row),
        animations: {
            cell.alpha = 1
    })
}      
```
这样一个简单的淡入效果就OK了.但这样做显然不够优雅,我们如果要在多个`TableView`使用这个效果该怎样封装呢?
#### 2. 使用工厂设计模式进行封装

##### 1. creator(创建者): `Animator`,用来传入参数,和设置动画

```swift
// Animation接收三个参数
typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }
        animation(cell, indexPath, tableView)
		// 确保每个cell动画只执行一次
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}
```

##### 2. product（产品): `AnimationFactory`,用来设置不同的动画类型

```swift
enum AnimationFactory {
    
    static func makeFade(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, _ in
            cell.alpha = 0
            
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }
    
    // ... 
}
```
将所有的动画设置封装在`Animation`的闭包中.  


最后我们就可以在`tableView(_:,willDisplay:,forRowAt:)`这个方法中使用了

```swift
let animation = AnimationFactory.makeFade(duration: 0.5, delayFactor: 0.05)
let animator = TableViewAnimator(animation: animation)
animator.animate(cell: cell, at: indexPath, in: tableView)
```

动画相关的可以参考我之前写的文章  [猛击](https://www.jianshu.com/p/6af8a7a8a15a)  
[实现效果](http://pcb5zz9k5.bkt.clouddn.com/TableViewRefreshAnimation2.gif)  
[示例Demo](https://github.com/DarielChen/SwiftTips/tree/master/Demo/11.%E5%8D%8E%E4%B8%BD%E7%9A%84TableView%E5%88%B7%E6%96%B0%E5%8A%A8%E6%95%88)  



<h2 id="12">12.实现一个不基于Runtime的KVO</h2> 
 
Swift并没有在语言层级上支持KVO,如果要使用必须导入`Foundation`框架, 被观察对象必须继承自`NSObject`,这种实现方式显然不够优雅.  

KVO本质上还是通过拿到属性的set方法去搞事情,基于这样的原理我们可以自己去实现.

#### 1. 实现
话不多说,直接贴代码,新建一个`Observable`文件

```swift
public class Observable<Type> {
    
    // MARK: - Callback
    fileprivate class Callback {
        fileprivate weak var observer: AnyObject?
        fileprivate let options: [ObservableOptions]
        fileprivate let closure: (Type, ObservableOptions) -> Void
        
        fileprivate init(
            observer: AnyObject,
            options: [ObservableOptions],
            closure: @escaping (Type, ObservableOptions) -> Void) {
            
            self.observer = observer
            self.options = options
            self.closure = closure
        }
    }
    
    // MARK: - Properties
    public var value: Type {
        didSet {
            removeNilObserverCallbacks()
            notifyCallbacks(value: oldValue, option: .old)
            notifyCallbacks(value: value, option: .new)
        }
    }
    
    private func removeNilObserverCallbacks() {
        callbacks = callbacks.filter { $0.observer != nil }
    }
    
    private func notifyCallbacks(value: Type, option: ObservableOptions) {
        let callbacksToNotify = callbacks.filter { $0.options.contains(option) }
        callbacksToNotify.forEach { $0.closure(value, option) }
    }
    
    // MARK: - Object Lifecycle
    public init(_ value: Type) {
        self.value = value
    }
    
    // MARK: - Managing Observers
    private var callbacks: [Callback] = []
    
    
    /// 添加观察者
    ///
    /// - Parameters:
    ///   - observer: 观察者
    ///   - removeIfExists: 如果观察者存在需要移除
    ///   - options: 被观察者
    ///   - closure: 回调
    public func addObserver(
        _ observer: AnyObject,
        removeIfExists: Bool = true,
        options: [ObservableOptions] = [.new],
        closure: @escaping (Type, ObservableOptions) -> Void) {
        
        if removeIfExists {
            removeObserver(observer)
        }
        
        let callback = Callback(observer: observer, options: options, closure: closure)
        callbacks.append(callback)
        
        if options.contains(.initial) {
            closure(value, .initial)
        }
    }
    
    public func removeObserver(_ observer: AnyObject) {
        callbacks = callbacks.filter { $0.observer !== observer }
    }
}

// MARK: - ObservableOptions
public struct ObservableOptions: OptionSet {
    
    public static let initial = ObservableOptions(rawValue: 1 << 0)
    public static let old = ObservableOptions(rawValue: 1 << 1)
    public static let new = ObservableOptions(rawValue: 1 << 2)
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

```
使用起来和KVO差不多.  
#### 2. 使用
需要监听的类

```swift
public class User {
    // 监听的属性需要是Observable类型
    public let name: Observable<String>
    
    public init(name: String) {
        self.name = Observable(name)
    }
}
```
使用

```swift
// 创建对象
let user = User(name: "Made")

// 设置监听
user.name.addObserver(self, options: [.new]) { name, change in
    print("name:\(name), change:\(change)")
}

// 修改对象的属性
user.name.value = "Amel"  // 这时就可以被监听到

// 移除监听
user.name.removeObserver(self)

```
> 注意: 在使用过程中,如果改变value, addObserver方法不调用,很有可能是Observer对象已经被释放掉了.

<h2 id="13">13.实现多重代理</h2>  

作为iOS开发中最常用的设计模式之一`Delegate`,只能是一对一的关系,如果要一对多,就只能使用`NSNotification`了,但我们可以有更好的解决方案,多重代理.

#### 1. 多重代理的实现过程

##### 1. 定义协议

```swift
protocol MasterOrderDelegate: class {
    func toEat(_ food: String)
}
```

##### 2. 定义一个类: 用来管理遵守协议的类

这边用了`NSHashTable`来存储遵守协议的类,`NSHashTable`和`NSSet`类似,但又有所不同,总的来说有这几个特点:  
	1. `NSHashTable`中的元素可以通过`Hashable`协议来判断是否相等.  
	2. `NSHashTable`中的元素如果是弱引用,对象销毁后会被移除,可以避免循环引用.  

```swift
class masterOrderDelegateManager : MasterOrderDelegate {
    private let multiDelegate: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    init(_ delegates: [MasterOrderDelegate]) {
        delegates.forEach(multiDelegate.add)
    }
    
    // 协议中的方法,可以有多个
    func toEat(_ food: String) {
        invoke { $0.toEat(food) }
    }
    
    // 添加遵守协议的类
    func add(_ delegate: MasterOrderDelegate) {
        multiDelegate.add(delegate)
    }
    
    // 删除指定遵守协议的类
    func remove(_ delegateToRemove: MasterOrderDelegate) {
        invoke {
            if $0 === delegateToRemove as AnyObject {
                multiDelegate.remove($0)
            }
        }
    }
    
    // 删除所有遵守协议的类
    func removeAll() {
        multiDelegate.removeAllObjects()
    }

    // 遍历所有遵守协议的类
    private func invoke(_ invocation: (MasterOrderDelegate) -> Void) {
        for delegate in multiDelegate.allObjects.reversed() {
            invocation(delegate as! MasterOrderDelegate)
        }
    }
}
```

##### 3. 其余部分

```swift
class Master {
    weak var delegate: MasterOrderDelegate?
    
    func orderToEat() {
        delegate?.toEat("meat")
    }
}

class Dog {
}
extension Dog: MasterOrderDelegate {
    func toEat(_ food: String) {
        print("\(type(of: self)) is eating \(food)")
    }
    
}

class Cat {
}
extension Cat: MasterOrderDelegate {
    func toEat(_ food: String) {
        print("\(type(of: self)) is eating \(food)")
    }
}

let cat = Cat()
let dog = Dog()
let cat1 = Cat()

let master = Master()
// master的delegate是弱引用,所以不能直接赋值
let delegate = masterOrderDelegateManager([cat, dog])
// 添加遵守该协议的类
delegate.add(cat1)
// 删除遵守该协议的类
delegate.remove(dog)

master.delegate = delegate
master.orderToEat()

// 输出
// Cat is eating meat
// Cat is eating meat
```

#### 2. 多重代理的应用场景
1. IM消息接收之后在多个地方做回调,比如显示消息,改变小红点,显示消息数.
2. `UISearchBar`的回调,当我们需要在多个地方获取数据的时候,类似的还有`UINavigationController`的回调等.


<h2 id="14">14.自动检查控制器是否被销毁</h2>  


检查内存泄漏除了使用`Instruments`,还有查看控制器`pop`或`dismiss`后是否被销毁,后者相对来说更方便一点.但老是盯着析构函数`deinit`看日志输出是否有点麻烦呢?


`UIViewController`有提供两个不知名的属性: 
 
 1. `isBeingDismissed`: 当modal出来的控制器被`dismiss`后的值为`true`.  
 2.  `isMovingFromParent`: 在控制器的堆栈中,如果当前控制器从父控制器中移除,值会变成`true`.


如果这两个属性都为`true`,表明控制器马上要被销毁了,但这是由ARC去做内存管理,我们并不知道多久之后被销毁,简单起见就设个2秒吧.

```swift
extension UIViewController {
    
    public func dch_checkDeallocation(afterDelay delay: TimeInterval = 2.0) {
        let rootParentViewController = dch_rootParentViewController
        
        if isMovingFromParent || rootParentViewController.isBeingDismissed {
            let disappearanceSource: String = isMovingFromParent ? "removed from its parent" : "dismissed"
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { [weak self] in
                if let VC = self {
                    assert(self == nil, "\(VC.description) not deallocated after being \(disappearanceSource)")
                }
            })
        }
    }
    private var dch_rootParentViewController: UIViewController {
        var root = self
        while let parent = root.parent {
            root = parent
        }
        return root
    }
}
```
我们把这个方法添加到`viewDidDisappear(_:)`中

```swift
override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    dch_checkDeallocation()
}
```
如果发生循环引用,控制就不会被销毁,会触发`assert`报错.


<h2 id="15">15.向控制器中注入代码</h2>  

使用场景: 在某些控制器的`viewDidLoad`方法中,我们需要添加一段代码,用于统计某个页面的打开次数.  

最常用的解决方案:   
在父类或者`extension`中定义一个方法,然后在需要做统计的控制器的`viewDidLoad`方法中调用刚刚定义好的方法.

或者还可以使用代码注入.
#### 1. 代码注入的使用


```swift
ViewControllerInjector.inject(into: [ViewController.self], selector: #selector(UIViewController.viewDidLoad)) {

	// $0 为ViewController对象            
	// 统计代码...
}
```

#### 2.代码注入的实现

swift虽然是门静态语言,但依然支持OC的`runtime`.可以允许我们在静态类型中使用动态代码.代码注入就是通过`runtime`的交换方法实现的.

```swift
class ViewControllerInjector {
    
    typealias methodRef = @convention(c)(UIViewController, Selector) -> Void
    
    static func inject(into supportedClasses: [UIViewController.Type], selector: Selector, injection: @escaping (UIViewController) -> Void) {
        
        guard let originalMethod = class_getInstanceMethod(UIViewController.self, selector) else {
            fatalError("\(selector) must be implemented")
        }
        
        var originalIMP: IMP? = nil
        
        let swizzledViewDidLoadBlock: @convention(block) (UIViewController) -> Void = { receiver in
            if let originalIMP = originalIMP {
                let castedIMP = unsafeBitCast(originalIMP, to: methodRef.self)
                castedIMP(receiver, selector)
            }
            
            if ViewControllerInjector.canInject(to: receiver, supportedClasses: supportedClasses) {
                injection(receiver)
            }
        }
        
        let swizzledIMP = imp_implementationWithBlock(unsafeBitCast(swizzledViewDidLoadBlock, to: AnyObject.self))
        originalIMP = method_setImplementation(originalMethod, swizzledIMP)
    }
    
    
    private static func canInject(to receiver: Any, supportedClasses: [UIViewController.Type]) -> Bool {
        let supportedClassesIDs = supportedClasses.map { ObjectIdentifier($0) }
        let receiverType = type(of: receiver)
        return supportedClassesIDs.contains(ObjectIdentifier(receiverType))
    }
}
```
代码注入可以在不修改原有代码的基础上自定义自己所要的.相比继承,代码的可重用性会高一点,侵入性会小一点. 



<h2 id="16">16.给Extension添加存储属性</h2>  

我们都知道`Extension`中可以添加计算属性,但不能添加存储属性.  

对 我们可以使用`runtime`  

```swift
private var nameKey: Void?
extension UIView {
    // 给UIView添加一个name属性
    var name: String? {
        get {
            return objc_getAssociatedObject(self, &nameKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &nameKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
```


<h2 id="17">17.用闭包实现按钮的链式点击事件</h2>  

#### 1. 通常姿势

通常按钮的点击事件我们需要这样写:

```swift
btn.addTarget(self, action: #selector(actionTouch), for: .touchUpInside)

@objc func actionTouch() {
    print("按钮点击事件")
}
```
如果有多个点击事件,往往还要写多个方法,写多了有没有觉得有点烦,代码阅读起来还要上下跳转.

#### 2. 使用闭包封装
##### 1. 实现  

```swift
private var actionDictKey: Void?
public typealias ButtonAction = (UIButton) -> ()

extension UIButton {
    
    // MARK: - 属性
    // 用于保存所有事件对应的闭包
    private var actionDict: (Dictionary<String, ButtonAction>)? {
        get {
            return objc_getAssociatedObject(self, &actionDictKey) as? Dictionary<String, ButtonAction>
        }
        set {
            objc_setAssociatedObject(self, &actionDictKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    // MARK: - API
    @discardableResult
    public func addTouchUpInsideAction(_ action: @escaping ButtonAction) -> UIButton {
        self.addButton(action: action, for: .touchUpInside)
        return self
    }
    
    @discardableResult
    public func addTouchUpOutsideAction(_ action: @escaping ButtonAction) -> UIButton {
        self.addButton(action: action, for: .touchUpOutside)
        return self
    }
    
    @discardableResult
    public func addTouchDownAction(_ action: @escaping ButtonAction) -> UIButton {
        self.addButton(action: action, for: .touchDown)
        return self
    }
    
    // ...其余事件可以自己扩展
    
    // MARK: - 私有方法
    private func addButton(action: @escaping ButtonAction, for controlEvents: UIControl.Event) {
        
        let eventKey = String(controlEvents.rawValue)

        if var actionDict = self.actionDict {
            actionDict.updateValue(action, forKey: eventKey)
            self.actionDict = actionDict
        }else {
            self.actionDict = [eventKey: action]
        }

        switch controlEvents {
        case .touchUpInside:
            addTarget(self, action: #selector(touchUpInsideControlEvent), for: .touchUpInside)
        case .touchUpOutside:
            addTarget(self, action: #selector(touchUpOutsideControlEvent), for: .touchUpOutside)
        case .touchDown:
            addTarget(self, action: #selector(touchDownControlEvent), for: .touchDown)
        default:
            break
        }
    }
    
    // 响应事件
    @objc private func touchUpInsideControlEvent() {
        executeControlEvent(.touchUpInside)
    }
    @objc private func touchUpOutsideControlEvent() {
        executeControlEvent(.touchUpOutside)
    }
    @objc private func touchDownControlEvent() {
        executeControlEvent(.touchDown)
    }
    
    @objc private func executeControlEvent(_ event: UIControl.Event) {
        let eventKey = String(event.rawValue)
        if let actionDict = self.actionDict, let action = actionDict[eventKey] {
            action(self)
        }
    }
}

```

##### 2. 使用 

```swift
 btn
    .addTouchUpInsideAction { btn in
        print("addTouchUpInsideAction")
    }.addTouchUpOutsideAction { btn in
        print("addTouchUpOutsideAction")
    }.addTouchDownAction { btn in
        print("addTouchDownAction")
    }
```
##### 3. 实现原理
利用`runtime`在按钮的`extension`中添加一个字典属性,`key`对应的是事件类型,`value`对应的是该事件类型所要执行的闭包.然后再添加按钮的监听事件,在响应方法中,根据事件类型找到并执行对应的闭包.

链式调用就是不断返回自身.

有没有觉得如果这样做代码写起来会简洁一点呢?


<h2 id="18">18.用闭包实现手势的链式监听事件</h2>  

和tips17中的按钮点击事件类似,手势也可以封装成链式闭包回调.

#### 1. 使用

```swift
view
    .addTapGesture { tap in
        print(tap)
    }.addPinchGesture { pinch in
        print(pinch)
    }
```

#### 2. 实现过程

```swift
public typealias GestureClosures = (UIGestureRecognizer) -> Void
private var gestureDictKey: Void?

extension UIView {
    private enum GestureType: String {
        case tapGesture
        case pinchGesture
        case rotationGesture
        case swipeGesture
        case panGesture
        case longPressGesture
    }

    // MARK: - 属性
    private var gestureDict: [String: GestureClosures]? {
        get {
            return objc_getAssociatedObject(self, &gestureDictKey) as? [String: GestureClosures]
        }
        set {
            objc_setAssociatedObject(self, &gestureDictKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    // MARK: - API
    /// 点击
    @discardableResult
    public func addTapGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .tapGesture)
        return self
    }
    /// 捏合
    @discardableResult
    public func addPinchGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .pinchGesture)
        return self
    }
   	 // ...省略相关手势
   	 
    // MARK: - 私有方法
    private func addGesture(gesture: @escaping GestureClosures, for gestureType: GestureType) {
        let gestureKey = String(gestureType.rawValue)
        if var gestureDict = self.gestureDict {
            gestureDict.updateValue(gesture, forKey: gestureKey)
            self.gestureDict = gestureDict
        } else {
            self.gestureDict = [gestureKey: gesture]
        }
        isUserInteractionEnabled = true
        switch gestureType {
        case .tapGesture:
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
            addGestureRecognizer(tap)
        case .pinchGesture:
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureAction(_:)))
            addGestureRecognizer(pinch)
        default:
            break
        }
    }
    @objc private func tapGestureAction (_ tap: UITapGestureRecognizer) {
        executeGestureAction(.tapGesture, gesture: tap)
    }
    @objc private func pinchGestureAction (_ pinch: UIPinchGestureRecognizer) {
        executeGestureAction(.pinchGesture, gesture: pinch)
    }
   
    private func executeGestureAction(_ gestureType: GestureType, gesture: UIGestureRecognizer) {
        let gestureKey = String(gestureType.rawValue)
        if let gestureDict = self.gestureDict, let gestureReg = gestureDict[gestureKey] {
            gestureReg(gesture)
        }
    }
}
```

具体实现 [猛击](https://github.com/DarielChen/SwiftTips/blob/master/SwiftTipsDemo/DCTool/Extension/UIView%2BExtension.swift)

<h2 id="19">19.用闭包实现通知的监听事件</h2>   

#### 1. 使用

```swift
// 通知监听
self.observerNotification(.notifyName1) { notify in
    print(notify.userInfo)
}
// 发出通知
self.postNotification(.notifyName1, userInfo: ["infoKey": "info"])

// 移除通知
self.removeNotification(.notifyName1)
```

#### 2. 实现

```swift
public typealias NotificationClosures = (Notification) -> Void
private var notificationActionKey: Void?

// 用于存放通知名称
public enum NotificationNameType: String {
    case notifyName1
    case notifyName2
}

extension NSObject {
    private var notificationClosuresDict: [NSNotification.Name: NotificationClosures]? {
        get {
            return objc_getAssociatedObject(self, &notificationActionKey)
                as? [NSNotification.Name: NotificationClosures]
        }
        set {
            objc_setAssociatedObject(self, &notificationActionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    public func postNotification(_ name: NotificationNameType, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: self, userInfo: userInfo)
    }
    public func observerNotification(_ name: NotificationNameType, action: @escaping NotificationClosures) {
        if var dict = notificationClosuresDict {
            guard dict[NSNotification.Name(name.rawValue)] == nil else {
                return
            }
            dict.updateValue(action, forKey: NSNotification.Name(name.rawValue))
            self.notificationClosuresDict = dict
        } else {
            self.notificationClosuresDict = [NSNotification.Name(name.rawValue): action]
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction),
                                               name: NSNotification.Name(name.rawValue), object: nil)
    }
    public func removeNotification(_ name: NotificationNameType) {
        NotificationCenter.default.removeObserver(self)
        notificationClosuresDict?.removeValue(forKey: NSNotification.Name(name.rawValue))
    }
    @objc func notificationAction(notify: Notification) {
        if let notificationClosures = notificationClosuresDict, let closures = notificationClosures[notify.name] {
            closures(notify)
        }
    }
}
```
具体实现过程和tips17、tips18类似.


<h2 id="20">20.使用命令模式给AppDelegate解耦</h2>  

作为iOS整个项目的核心`App delegate`,随着项目的逐渐变大,会变得越来越臃肿,一不小心代码就过了千行.  

大型项目的`App delegate`体积会大到什么程度呢?我们可以参考下国外2亿多月活的`Telegram`的 [App delegate](https://github.com/peter-iakovlev/Telegram/blob/public/Telegraph/TGAppDelegate.mm).是不是吓一跳,4千多行.看到这样的代码我一般都是直接点击左上角的x的.

是时候该给`App delegate`解耦了,目标: 每个功能的配置或者初始化都分开,各自做各自的事情.`App delegate`要做到我只需要调用就好了.命令模式就正好满足这一点.

> 命令模式: 发送方发送请求,然后接收方接受请求后执行,但发送方可能并不知道接受方是谁，执行的是什么操作,这样做的好处是发送方和接受方完全的松耦合，大大提高程序的灵活性.

##### 1. 定义好协议,把相关初始化配置代码分类

```swift
protocol Command {
    func execute()
}

struct InitializeThirdPartiesCommand: Command {
    func execute() {
        // 第三方库初始化代码
    }
}

struct InitialViewControllerCommand: Command {
    let keyWindow: UIWindow
    func execute() {
        // 根控制器设置代码
    }
}

struct InitializeAppearanceCommand: Command {
    func execute() {
        // 全局外观样式配置
    }
}

struct RegisterToRemoteNotificationsCommand: Command {
    func execute() {
        // 远程推送配置        
    }
}

```
##### 2. 管理者

```swift

final class StartupCommandsBuilder {
    private var window: UIWindow!
    
    func setKeyWindow(_ window: UIWindow) -> StartupCommandsBuilder {
        self.window = window
        return self
    }
    
    func build() -> [Command] {
        return [
            InitializeThirdPartiesCommand(),
            InitialViewControllerCommand(keyWindow: window),
            InitializeAppearanceCommand(),
            RegisterToRemoteNotificationsCommand()
        ]
    }
}
```

##### 3. `App delegate`调用

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        StartupCommandsBuilder()
            .setKeyWindow(window!)
            .build()
            .forEach { $0.execute() }
        
        return true
}
```

使用命令模式的好处是,如果要添加新的配置,设置完后只要加在`StartupCommandsBuilder`中就可以了.`App delegate`中不需要添加任何内容.


<h2 id="21">21.常见的编译器诊断指令</h2>  
swift标准库提供了很多编译器诊断指令,用于在编译阶段提前处理好相关事情.

下面列出了一些常见的编译器诊断指令:

##### 1. 代码中警告错误标识: #warning和#error
swift4.2中添加了这两个命令,再也不用在项目中自己配置错误和警告的命令了.  

警告⚠️:

```swift
// Xcode会报一条黄色警告
#warning("此处逻辑有问题,明天再说")

// TODO
#warning("TODO: Update this code for the new iOS 12 APIs")
```
错误❌:

```swift
// 手动设置一条错误
#error("This framework requires UIKit!")
```

##### 2. #if - #endif 条件判断

```swift
#if !canImport(UIKit)
#error("This framework requires UIKit!")
#endif

#if DEBUG
#warning("TODO: Update this code for the new iOS 12 APIs")
#endif        
```

##### 3. #file、#function、#line
分别用于获取文件名,函数名称,当前所在行数,一般用于辅助日志输出.

自定义Log

```swift
public struct dc {
    
    /// 自定义Log
    ///
    /// - Parameters:
    ///   - message: 输出的内容
    ///   - file: 默认
    ///   - method: 默认
    ///   - line: 默认
    public static func log<T>(_ message: T, file: NSString = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
        print("\(file.pathComponents.last!):\(method)[\(line)]: \(message)")
        #endif
    }
}
```

##### 4. #available和@available

一般用来判断当前代码块在某个版本及该版本以上是否可用.

```swift
if #available(iOS 8, *) {
    // iOS 8 及其以上系统运行
}

guard #available(iOS 8, *) else {
    return //iOS 8 以下系统就直接返回
}

@available(iOS 11.4, *)
func myMethod() {
    // do something
}
```


