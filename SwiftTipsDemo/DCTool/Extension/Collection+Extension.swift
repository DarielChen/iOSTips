//
//  Collection+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/16.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

extension Collection {
    /// 判断是否有满足条件的元素
    ///
    /// [1, 2, 3, 4, 5].all { $0 > 10 }
    /// false
    func all(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        for item in self {
            let result = try predicate(item)
            if !result {
                return false
            }
        }
        return true
    }
}
