import UIKit

// for循环的时候添加限定条件
let arr = [11, 12, 13, 14, 15, 16, 17, 18]
for num in arr where num % 2 == 0 {
    // 12 14 16 18
}


// 在try catch的时候做条件判断
enum ExceptionError:Error{
    case httpCode(Int)
}

func throwError() throws {
    throw ExceptionError.httpCode(500)
}

do{
    try throwError()
}catch ExceptionError.httpCode(let httpCode) where httpCode >= 500{
    print("server error")
}catch {
    print("other error")
}


// switch语句做限定条件
let student:(name:String, score:Int) = ("小明", 59)
switch student {
case let (_,score) where score < 60:
    print("不及格")
default:
    print("及格")
}

// 限定泛型需要遵守的协议
//第一种写法
func genericFunctionA<S>(str:S) where S:ExpressibleByStringLiteral{
    print(str)
}
//第二种写法
func genericFunctionB<S:ExpressibleByStringLiteral>(str:S){
    print(str)
}


// 为指定的类添加对应的协议扩展
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
