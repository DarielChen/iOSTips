//
//  AuthCoordinator.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func didAuthenticate()
}

// 用户授权模块的Coordinator
final class AuthCoordinator: Coordinator {
    
    private let navController: UINavigationController
    weak var delegate: AuthCoordinatorDelegate?
    
    init(navController: UINavigationController, delegate: AuthCoordinatorDelegate) {
        self.navController = navController
        self.delegate = delegate
    }
    
    func start() {
        let authVc = UIStoryboard.instantiateAuthViewController(delegate: self)
        navController.setViewControllers([authVc], animated: true)
    }
}

extension AuthCoordinator: AuthViewControllerDelegate {
    func signIn() {
        delegate?.didAuthenticate()
    }
}
