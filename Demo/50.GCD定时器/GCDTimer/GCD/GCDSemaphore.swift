//
//  GCDSemaphore.swift
//  GCDTimer
//
//  Created by Dariel on 2019/4/2.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class GCDSemaphore {
    
    public let dispatchSemaphore : DispatchSemaphore
    
    init(initialSignal : Int = 0) {
        
        self.dispatchSemaphore = DispatchSemaphore(value: initialSignal)
    }
    
    // MARK: Singal
    
    /// 发信号
    func signal() {
        
        self.dispatchSemaphore.signal()
    }
    
    // MARK: Wait
    
    /// [阻塞操作] 无限等待
    func wait() {
        
        self.dispatchSemaphore.wait()
    }
    
    /// [阻塞操作] 等待指定的时间
    ///
    /// - Parameter seconds: 等待的时间,最多精确到1ms
    /// - Returns: DispatchTimeoutResult对象
    func waitForSeconds(_ seconds : Float) -> DispatchTimeoutResult {
        
        return self.dispatchSemaphore.wait(timeout: DispatchTime.now() + .milliseconds(Int(seconds * 1000)))
    }
}
