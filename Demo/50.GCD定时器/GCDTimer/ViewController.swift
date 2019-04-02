//
//  ViewController.swift
//  GCDTimer
//
//  Created by Dariel on 2019/4/2.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 设置定时器，延迟2秒执行，间隔1秒
        let gcdTimer = GCDTimer(in: GCDQueue.global(), delay: 2, interval: 1)
        
        var count : Int = 0
        // 执行事件
        gcdTimer.setTimerEventHandler { _ in
            count += 1
            print("\(count)")
            
            if count == 8 {
                // 定时器销毁
                gcdTimer.destroy()
            }
        }
        // 定时器开始
        gcdTimer.start()
        
        gcdTimer.setDestroyEventHandler {
            print("销毁事件的回调")
        }
        
    }
    
    
    func gcdUse() {
        
//        // 在主队列中操作
//        GCDQueue.main.excute {
//            print(Thread.current)
//        }
        
//        // 在全局队列中操作
//        GCDQueue.global().excute {
//            print(Thread.current)
//        }
        
        // 在并发线程中同步执行
//        GCDQueue.concurrent().excute {
//
//            GCDQueue.global().excuteAndWaitsUntilTheBlockCompletes {
//                for i in 0..<5 {
//                    print("🐴" + String(i))
//                }
//            }
//
//            GCDQueue.global().excuteAndWaitsUntilTheBlockCompletes {
//                for i in 0..<5 {
//                    print("🐳" + String(i))
//                }
//            }
//
//            GCDQueue.global().excuteAndWaitsUntilTheBlockCompletes {
//                for i in 0..<5 {
//                    print("🐒" + String(i))
//                }
//            }
//
//            GCDQueue.global().excuteAndWaitsUntilTheBlockCompletes {
//                for i in 0..<5 {
//                    print("🐇" + String(i))
//                }
//            }
//        }
        
//        // 在全局队列中延迟2秒操作
//        GCDQueue.global().excuteAfterDelay(2) {
//            print(Thread.current)
//        }
        
        
//        // 执行串行操作
//        let serialQueue = GCDQueue.serial()
//        serialQueue.excute {
//            print("A.\(Thread.current)")
//        }
//        serialQueue.excute {
//            print("B.\(Thread.current)")
//        }
//
        
//        // 执行并行操作
//        let concurrentQueue = GCDQueue.concurrent()
//        concurrentQueue.excute {
//            print("A.\(Thread.current)")
//        }
//        concurrentQueue.excute {
//            print("B.\(Thread.current)")
//        }
//        concurrentQueue.excute {
//            print("C.\(Thread.current)")
//        }
        
//        // GCD组正常使用
//        let group = GCDGroup()
//        GCDQueue.global().excuteInGroup(group) {
//            print("Do work A.")
//        }
//        GCDQueue.global().excuteInGroup(group) {
//            print("Do work B.")
//        }
//        GCDQueue.global().excuteInGroup(group) {
//            print("Do work C.")
//        }
//        GCDQueue.global().excuteInGroup(group) {
//            print("Do work D.")
//        }
//        group.notifyIn(GCDQueue.main) {
//            print("Finish.")
//        }
//
        
//        let group = GCDGroup()
//
//        group.enter()
//        group.enter()
//        group.enter()
//
//        print("Start.")
//
//        GCDQueue.ExcuteInGlobalAfterDelay(3) {
//
//            print("Do work A.")
//            group.leave()
//        }
//
//        GCDQueue.ExcuteInGlobalAfterDelay(4) {
//
//            print("Do work B.")
//            group.leave()
//        }
//
//        GCDQueue.ExcuteInGlobalAfterDelay(2) {
//
//            print("Do work C.")
//            group.leave()
//        }
//
//        // Notify in queue by group.
//        group.notifyIn(GCDQueue.Main) {
//
//            print("Finish.")
//        }
        
//        let group = GCDGroup()
//
//        group.enter()
//        group.enter()
//
//        print("Start.")
//
//        GCDQueue.ExcuteInGlobalAfterDelay(3) {
//
//            print("Do work A.")
//            group.leave()
//        }
//
//        GCDQueue.ExcuteInGlobalAfterDelay(5) {
//
//            print("Do work B.")
//            group.leave()
//        }
//
//        let waitSeconds = arc4random() % 2 == 0 ? 4 : 6
//        print("wait \(waitSeconds) seconds.")
//        print(group.waitForSeconds(seconds: Float(waitSeconds)))
//        print("wait finish.")
//
//        // Notify in queue by group.
//        group.notifyIn(GCDQueue.Main) {
//
//            print("Finish.")
//        }
        
//        let semaphore = GCDSemaphore()
//
//        print("start.")
//
//        GCDQueue.Global().excute {
//
//            semaphore.wait()
//            print("Done 1")
//
//            semaphore.wait()
//            print("Done 2")
//        }
//
//        GCDQueue.Global().excuteAfterDelay(3) {
//
//            semaphore.signal()
//        }
//
//        GCDQueue.Global().excuteAfterDelay(4) {
//
//            semaphore.signal()
//        }
        
//        let semaphore = GCDSemaphore()
//
//        print("start.")
//
//        GCDQueue.Global().excute {
//
//            _ = semaphore.waitForSeconds(3)
//            print("Done")
//        }
//
//        GCDQueue.Global().excuteAfterDelay(5) {
//
//            print("signal")
//            semaphore.signal()
//        }
        
    }
}

