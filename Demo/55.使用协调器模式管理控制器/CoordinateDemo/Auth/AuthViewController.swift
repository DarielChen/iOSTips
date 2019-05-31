//
//  AuthViewController.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func signIn()
}

class AuthViewController: UIViewController {
    
    weak var delegate: AuthViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signInTouch(_ sender: Any) {
        delegate?.signIn()
    }
    
    deinit {
        print("AuthViewController销毁")
    }
}
