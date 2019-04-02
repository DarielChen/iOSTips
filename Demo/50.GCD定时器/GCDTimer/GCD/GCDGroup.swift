//
//  GCDGroup.swift
//  GCDTimer
//
//  Created by Dariel on 2019/4/2.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class GCDGroup {
    
    public let dispatchGroup : DispatchGroup
    
    init() {
        
        self.dispatchGroup = DispatchGroup()
    }
    
    /// 在指定的queue里面获取消息
    ///
    /// - Parameters:
    ///   - queue: 指定的queue
    ///   - execute: 执行的block
    func notifyIn(_ queue : GCDQueue, execute: @escaping () -> Void) {
        
        self.dispatchGroup.notify(queue: queue.dispatchQueue, execute: execute)
    }
    
    /// 进入group
    func enter() {
        
        self.dispatchGroup.enter()
    }
    
    /// 从group出来
    func leave() {
        
        self.dispatchGroup.leave()
    }
    
    /// [阻塞操作] 无限等待
    func wait() {
        
        self.dispatchGroup.wait()
    }
    
    /// [阻塞操作] 等待指定的时间
    ///
    /// - Parameter seconds: 等待的时间,最多精确到1ms
    /// - Returns: DispatchTimeoutResult对象
    func waitForSeconds(seconds : Float) -> DispatchTimeoutResult {
        
        return self.dispatchGroup.wait(timeout: .now() + .milliseconds(Int(seconds * 1000)))
    }
}
