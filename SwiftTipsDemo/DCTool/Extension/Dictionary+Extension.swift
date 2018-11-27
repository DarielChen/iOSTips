//
//  Dictionary+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/11/27.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

extension Dictionary where Key: StringProtocol {
    /// dict[keyPath: "key.key2.key3"]方式取值和设置值
    ///
    /// - Parameter keyPath: 每个key之间以.g分隔
    subscript(keyPath keyPath: KeyPath) -> Any? {
        get {
            switch keyPath.headAndTail() {
            case nil:
                return nil
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                return self[Key(string: head)]
            case let (head, remainingKeyPath)?:
                let key = Key(string: head)
                switch self[key] {
                case let nestedDict as [Key: Any]:
                    return nestedDict[keyPath: remainingKeyPath]
                default:
                    return nil
                }
            }
        }
        set {
            switch keyPath.headAndTail() {
            case nil:
                return
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                let key = Key(string: head)
                self[key] = newValue as? Value
            case let (head, remainingKeyPath)?:
                let key = Key(string: head)
                let value = self[key]
                switch value {
                case var nestedDict as [Key: Any]:
                    nestedDict[keyPath: remainingKeyPath] = newValue
                    self[key] = nestedDict as? Value
                default:
                    return
                }
            }
        }
    }
}
struct KeyPath {
    var segments: [String]
    var isEmpty: Bool { return segments.isEmpty }
    var path: String {
        return segments.joined(separator: ".")
    }
    func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
}
extension KeyPath {
    init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
}
extension KeyPath: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
    init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}
protocol StringProtocol {
    init(string: String)
}
extension String: StringProtocol {
    init(string: String) {
        self = string
    }
}
