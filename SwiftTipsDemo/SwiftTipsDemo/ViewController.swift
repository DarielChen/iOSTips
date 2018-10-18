//
//  ViewController.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/9/28.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view
            .addTapGesture { tap in
                print(tap)
            }.addPinchGesture { pinch in
                print(pinch)
            }.addRotationGesture { rotation in
                print(rotation)
            }.addSwipeGesture { swipe in
                print(swipe)
            }.addPanGesture { pan in
                print(pan)
            }.addLongPressGesture { longPress in
                print(longPress)
            }
    }
}
