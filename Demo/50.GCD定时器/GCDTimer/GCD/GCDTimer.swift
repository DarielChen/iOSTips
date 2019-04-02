//
//  GCDTimer.swift
//  GCDTimer
//
//  Created by Dariel on 2019/4/2.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class GCDTimer {
    
    public let dispatchSourceTimer : DispatchSourceTimer
    
    init(in : GCDQueue, delay : Float = 0, interval : Float) {
        dispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: `in`.dispatchQueue)
        dispatchSourceTimer.schedule(deadline: .now() + .milliseconds(Int(delay * 1000)), repeating: .milliseconds(Int(interval * 1000)))
    }
    
    /// 设定定时器任务的回调函数
    ///
    /// - Parameter eventHandler: 回调函数
    func setTimerEventHandler(eventHandler: @escaping (GCDTimer) -> Void) {
        dispatchSourceTimer.setEventHandler {
            eventHandler(self)
        }
    }
    
    /// 设定定时器销毁时候的回调函数
    ///
    /// - Parameter eventHandler: 回调函数
    func setDestroyEventHandler(eventHandler: @escaping () -> Void) {
        
        dispatchSourceTimer.setCancelHandler {
            eventHandler()
        }
    }
    
    /// 挂起
    func suspend() {
         dispatchSourceTimer.suspend()
    }
    
    /// 开始定时
    func start() {
         dispatchSourceTimer.resume()
    }
    
    /// 定时器销毁(执行了此方法后,start就会变得无效)
    func destroy() {
         dispatchSourceTimer.cancel()
    }
}
