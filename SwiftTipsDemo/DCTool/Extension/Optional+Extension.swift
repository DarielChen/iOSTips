//
//  Optional+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/11/20.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import Foundation

extension Optional {
    /// 判断是否为空
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    /// 判断是否有值
    var isSome: Bool {
        return !isNone
    }
    /// 返回解包后的值或者默认值
    func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }
    /// 返回解包后的值或`else`表达式的值
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    /// 返回解包后的值或执行闭包返回值
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    /// 当可选值不为空时，执行 `some` 闭包
    func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }
    /// 当可选值为空时，执行 `none` 闭包
    func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
    /// 当两个可选值都不为空时返回解包后的元组，否则返回空
    func zip2<A>(with other: A?) -> (Wrapped, A)? {
        guard let first = self, let second = other else { return nil }
        return (first, second)
    }
    /// 当三个可选值都不为空时返回解包后的数组，否则返回空
    func zip3<A, B>(with other: A?, another: B?) -> [Any]? {
        guard let first = self,
            let second = other,
            let third = another else { return nil }
        return [first, second, third]
    }
    /// 可选值不为空时解包后的值,否则crash
    func expect(_ message: String) -> Wrapped {
        guard let value = self else { fatalError(message) }
        return value
    }
}

extension Optional {
    /// 返回解包后的`map`过的值，如果为空，则返回默认值
    func map<T>(_ closure: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(closure) ?? `default`
    }
    /// 返回解包后的`map`过的值，如果为空，则调用else闭包
    func map<T>(_ closure: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(closure) ?? `else`()
    }
    /// 可选值不为空时执行then闭包,返回执行结果
    /// 可链式调用
    func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }
    /// 可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
            predicate(unwrapped) else { return nil }
        return self
    }
}
