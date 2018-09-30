//
//  DCTool.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/9/30.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import Foundation


/// 判断多个值中是否包含某一个值
///
/// - Parameter values: 需要比较的值,可以是多个
/// - Returns: 可以用` ==`比较的类型
///
/// let string = "One"
///
/// if string == any(of: "One", "Two", "Three") {
/// 
/// }
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


