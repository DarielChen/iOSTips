//
//  ViewController.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func logout()
    func toMessage()
}

class MainViewController: UIViewController {
    weak var delegate: MainViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        delegate?.logout()
    }
    
    @IBAction func messageTouch(_ sender: Any) {
        delegate?.toMessage()
    }
    
    deinit {
        print("MainViewController销毁")
    }
    
}

