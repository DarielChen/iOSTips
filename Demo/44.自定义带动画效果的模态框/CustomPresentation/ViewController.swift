//
//  ViewController.swift
//  CustomPresentation
//
//  Created by Dariel on 2019/2/19.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // alert actionSheet
        _ = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
    }

    @IBAction func addtoastViewAction(_ sender: Any) {
        
        presentToast(title: "这是一条从底部弹出来的Toast,当文本过长的话可以支持自动换行哦")
    }
    
    @IBAction func addActionSheetAction(_ sender: Any) {
        
        let viewController = CustomActionsheetController()
        present(viewController, animated: true, completion: nil)
    }
    
    private func presentToast(title: String) {
        let toast = ToastViewController(title: title)
        present(toast, animated: true)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            toast.dismiss(animated: true)
        }
    }
    
}

