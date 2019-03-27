//
//  TestViewController.swift
//  keepThreadAlive
//
//  Created by Dariel on 2019/3/26.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    let thread = PermenantThread()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func excuteTaskTouch(_ sender: Any) {
        thread.executeTask {
            print(Thread.current)
        }
    }
    @IBAction func stopTaskTouch(_ sender: Any) {
        thread.stop()
    }
    
    deinit {
        print("TestViewController被销毁")
    }
}
