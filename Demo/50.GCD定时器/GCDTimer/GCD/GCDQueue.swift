//
//  GCDQueue.swift
//  GCDTimer
//
//  Created by Dariel on 2019/4/2.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class GCDQueue {
    
    public let dispatchQueue: DispatchQueue
    
    init(dispatchQueue : DispatchQueue) {
        
        self.dispatchQueue = dispatchQueue
    }
    
    /// 获取主队列
    public class var main: GCDQueue {
        
        return GCDQueue.init(dispatchQueue: DispatchQueue.main)
    }
    
    /// 获取全局并发队列
    ///
    /// - Parameter priority: 优先级
    /// - Returns: 全局并发队列
    public class func global(_ priority : GCDQueuePriority = .DefaultPriority) -> GCDQueue {
        
        return GCDQueue.init(dispatchQueue: DispatchQueue.global(qos: priority.getDispatchQoSClass()))
    }
    
    // MARK: concurrentQueue & serialQueue
    
    /// 获取并发队列
    ///
    /// - Parameters:
    ///   - label: 线程标签
    ///   - priority: 优先级
    /// - Returns: 并发队列
    public class func concurrent(_ label : String = "", _ priority : GCDQueuePriority = .DefaultPriority) -> GCDQueue {
        
        return GCDQueue.init(dispatchQueue: DispatchQueue(label: label, qos: priority.getDispatchQoS(), attributes: .concurrent))
    }
    
    /// 获取串行队列
    ///
    /// - Parameters:
    ///   - label: 线程标签
    ///   - priority: 优先级
    /// - Returns: 串行队列
    public class func serial(_ label : String = "", _ priority : GCDQueuePriority = .DefaultPriority) -> GCDQueue {
        
        return GCDQueue.init(dispatchQueue: DispatchQueue(label: label, qos: priority.getDispatchQoS()))
    }
    
    // MARK: Excute
    
    /// 异步执行
    ///
    /// - Parameter excute: 执行的block
    public func excute(_ excute : @escaping ()-> Void) {
        
        dispatchQueue.async(execute: excute)
    }
    
    /// 延时异步执行
    ///
    /// - Parameters:
    ///   - seconds: 延时秒数,最多精确到1ms
    ///   - excute: 执行的block
    public func excuteAfterDelay(_ seconds : Float, _ excute : @escaping ()-> Void) {
        
        dispatchQueue.asyncAfter(deadline: .now() + .milliseconds(Int(seconds * 1000)), execute: excute)
    }
    
    /// 同步执行
    ///
    /// - Parameter excute: 执行的block
    public func excuteAndWaitsUntilTheBlockCompletes(_ excute : @escaping ()-> Void) {
        
        dispatchQueue.sync(execute: excute)
    }
    
    /// 在group中执行
    ///
    /// - Parameters:
    ///   - group: GCDGroup对象
    ///   - excute: 执行的block
    public func excuteInGroup(_ group : GCDGroup, _ excute : @escaping ()-> Void) {
        
        dispatchQueue.async(group: group.dispatchGroup, execute: excute)
    }
    
    // MARK: Class method for excute
    
    /// 在主线程执行
    ///
    /// - Parameter excute: 执行的block
    class func excuteInMain(_ excute : @escaping ()-> Void) {
        
        GCDQueue.main.excute(excute)
    }
    
    /// 在主线程延时执行
    ///
    /// - Parameters:
    ///   - seconds: 延时秒数,最多精确到1ms
    ///   - excute: 执行的block
    class func excuteInMainAfterDelay(_ seconds : Float, _ excute : @escaping ()-> Void) {
        
        GCDQueue.main.excuteAfterDelay(seconds, excute)
    }
    
    /// 在子线程执行
    ///
    /// - Parameters:
    ///   - priority: 优先级
    ///   - excute: 执行的block
    class func excuteInGlobal(_ priority : GCDQueuePriority = .DefaultPriority, _ excute : @escaping ()-> Void) {
        
        GCDQueue.global(priority).excute(excute)
    }
    
    /// 在子线程延时执行
    ///
    /// - Parameters:
    ///   - seconds: 延时秒数,最多精确到1ms
    ///   - excute: 执行的block
    class func excuteInGlobalAfterDelay(_ seconds : Float, _ excute : @escaping ()-> Void) {
        
        GCDQueue.global().excuteAfterDelay(seconds, excute)
    }
}
