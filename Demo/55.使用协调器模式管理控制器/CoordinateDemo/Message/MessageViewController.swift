//
//  MessageViewController.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

protocol MessageViewControllerDelegate: AnyObject {
    func toDetailMessage()
}

class MessageViewController: UIViewController {
    var delegate: MessageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.text = "MessageViewController"
        label.font = UIFont.systemFont(ofSize: 22)
        
        view.addSubview(label)
        
        label.sizeToFit()
        label.center = view.center
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.toDetailMessage()
    }
    
    deinit {
        print("MessageViewController销毁")
    }
}
