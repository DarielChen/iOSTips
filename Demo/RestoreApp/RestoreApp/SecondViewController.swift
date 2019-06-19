//
//  SecondViewController.swift
//  RestoreApp
//
//  Created by Dariel on 2019/6/19.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touch(_ sender: Any) {
        let vc = LastViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SecondViewController {

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)

        guard let input = inputField.text, isViewLoaded else {
            return
        }
        coder.encode(input, forKey: .encodingKeyFieldValue)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        assert(isViewLoaded, "We assume the controller is never restored without loading its view first.")
        inputField.text = coder.decodeObject(forKey: .encodingKeyFieldValue) as? String
    }

    override func applicationFinishedRestoringState() {
        print("Finished restoring everything.")
    }
}


fileprivate extension String {
    static let encodingKeyFieldValue = "encodingKeyFieldValue"
}
