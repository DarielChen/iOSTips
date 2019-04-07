//: [Previous](@previous)

import Foundation

protocol MasterOrderDelegate: class {
    func toEat(_ food: String)
}

// 用来管理遵守协议的类
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
let delegate = masterOrderDelegateManager([cat, dog])
delegate.add(cat1)
delegate.remove(dog)
master.delegate = delegate
master.orderToEat()
