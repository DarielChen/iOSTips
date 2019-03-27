//
//  PermenantThread.swift
//  keepThreadAlive
//
//  Created by Dariel on 2019/3/26.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class DCThread: Thread {
    deinit {
        print("DCThread被销毁")
    }
}

class PermenantThread: NSObject {
    
    private var innerThread: DCThread?
    private var isStopped = false
    
    override init() {
        super.init()

        innerThread = DCThread(block: { [weak self] in
            
            RunLoop.current.add(Port(), forMode: RunLoop.Mode.default)
            while self?.isStopped == false {
                RunLoop.current.run(mode: RunLoop.Mode.default, before: NSDate.distantFuture)
            }
        })
        
        innerThread?.name = "PermenantThread"
        innerThread?.start()
    }
    
    func executeTask(task: @escaping @convention(block)() -> Void) {
        
        guard let innerThread = innerThread else{
            return
        }
        
        self.perform(#selector(innerExecuteTask(task:)), on: innerThread, with: task, waitUntilDone: false)
    }
    
    func stop() {
        
        guard let innerThread = innerThread else{
            return
        }
        self.perform(#selector(innerStop), on: innerThread, with: nil, waitUntilDone: true)
    }
    
    @objc private func innerExecuteTask(task: @escaping @convention(block)() -> Void) {
        task()
    }
    
    @objc private func innerStop() {
        isStopped = true
        CFRunLoopStop(CFRunLoopGetCurrent());
        self.innerThread = nil
    }
    
    deinit {
        stop()
        print("PermenantThread被销毁")
    }
}
