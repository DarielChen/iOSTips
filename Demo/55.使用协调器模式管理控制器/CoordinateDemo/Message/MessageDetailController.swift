//
//  MessageDetailController.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class MessageDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.text = "MessageDetailController"
        label.font = UIFont.systemFont(ofSize: 22)
        
        view.addSubview(label)
        
        label.sizeToFit()
        label.center = view.center
    }
    
    deinit {
        print("MessageDetailController销毁")
    }
}
