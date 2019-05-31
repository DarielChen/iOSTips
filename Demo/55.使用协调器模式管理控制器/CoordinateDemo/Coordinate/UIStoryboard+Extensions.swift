//
//  UIStoryboard+Extension.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // MARK: - 获取对应的Storyboard
    private static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    private static var auth: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: nil)
    }
    
    // MARK: - Storyboard中控制器管理
    static func instantiateMainViewController(delegate: MainViewControllerDelegate) -> MainViewController {
        let mainVc = main.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainVc.delegate = delegate
        return mainVc
    }
    
    static func instantiateAuthViewController(delegate: AuthViewControllerDelegate) -> AuthViewController {
        let authVc = auth.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        authVc.delegate = delegate
        return authVc
    }
}
