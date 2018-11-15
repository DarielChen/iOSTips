//
//  MutexLock.swift
//  DCNavBar
//
//  Created by Dariel on 2018/11/15.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

/// 基础互斥协议,只有互斥调用的方式的方法
public protocol ScopedMutex {
    /// Perform work inside the mutex
    func sync<R>(execute work: () throws -> R) rethrows -> R
    func trySync<R>(execute work: () throws -> R) rethrows -> R?
}

/// 对互斥的定制性的协议加入了对应的具体的操作方法和一个锁对象
public protocol RawMutex: ScopedMutex {
    associatedtype MutexPrimitive
    /// The raw primitive is exposed as an "unsafe" public property for faster access in some cases
    var unsafeMutex: MutexPrimitive { get set }
    func unbalancedLock()
    func unbalancedTryLock() -> Bool
    func unbalancedUnlock()
}

extension RawMutex {
    public func sync<R>(execute work: () throws -> R) rethrows -> R {
        unbalancedLock()
        defer { unbalancedUnlock() }
        return try work()
    }
    public func trySync<R>(execute work: () throws -> R) rethrows -> R? {
        guard unbalancedTryLock() else { return nil }
        defer { unbalancedUnlock() }
        return try work()
    }
}
/// 基于`pthread_mutex_t`(安全的"FIFO"互斥锁)的基本封装,类型包括 "NORMAL" 和 "RECURSIVE". 用类来封装可以更好的管理 `pthread_mutex_t`的生命周期 预防发生异常的情况.
public final class PThreadMutex: RawMutex {
    public typealias MutexPrimitive = pthread_mutex_t
    //互斥锁的类型: 非递归使用 "PTHREAD_MUTEX_NORMAL"  递归使用 "PTHREAD_MUTEX_RECURSIVE".
    public enum PThreadMutexType {
        case normal
        case recursive
    }
    public var unsafeMutex = pthread_mutex_t()
    ///默认是普通模式, 可以创建递归锁
    public init(type: PThreadMutexType = .normal) {
        var attr = pthread_mutexattr_t()
        guard pthread_mutexattr_init(&attr) == 0 else {
            preconditionFailure()
        }
        switch type {
        case .normal:
            pthread_mutexattr_settype(&attr, Int32(PTHREAD_MUTEX_NORMAL))
        case .recursive:
            pthread_mutexattr_settype(&attr, Int32(PTHREAD_MUTEX_RECURSIVE))
        }
        guard pthread_mutex_init(&unsafeMutex, &attr) == 0 else {
            preconditionFailure()
        }
        pthread_mutexattr_destroy(&attr)
    }
    deinit {
        pthread_mutex_destroy(&unsafeMutex)
    }
    public func unbalancedLock() {
        pthread_mutex_lock(&unsafeMutex)
    }
    public func unbalancedTryLock() -> Bool {
        return pthread_mutex_trylock(&unsafeMutex) == 0
    }
    public func unbalancedUnlock() {
        pthread_mutex_unlock(&unsafeMutex)
    }
}

@available(OSX 10.12, iOS 10, tvOS 10, *)
public final class UnfairLock: RawMutex {
    public typealias MutexPrimitive = os_unfair_lock
    public init() {}
    public var unsafeMutex = os_unfair_lock()
    public func unbalancedLock() {
        os_unfair_lock_lock(&unsafeMutex)
    }
    public func unbalancedTryLock() -> Bool {
        return os_unfair_lock_trylock(&unsafeMutex)
    }
    public func unbalancedUnlock() {
        os_unfair_lock_unlock(&unsafeMutex)
    }
}
