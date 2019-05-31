//
//  AppCoordinator.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {

    // MARK: - 属性
    private let navController: UINavigationController
    private let window: UIWindow
    private var childCoordinators: [Coordinator] = []
    
    
    // MARK: - 构造方法
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    
    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
//        showMain()
        showAuth()
    }
    
    // MARK: - 导航
    private func showMain() {
        let mainVc  = UIStoryboard.instantiateMainViewController(delegate: self)
        navController.setViewControllers([mainVc], animated: true)
        
//        childCoordinators.removeAll()
    }
    
    private func showAuth() {
        let authCoordinator = AuthCoordinator(navController: navController, delegate: self)
        childCoordinators.append(authCoordinator)
        
        authCoordinator.start()
    }

    private func showMessage() {
        let messageCoordinator = MessageCoordinator(navController: navController)
        
        messageCoordinator.start()
    }

}


extension AppCoordinator: MainViewControllerDelegate {
    func toMessage() {
        showMessage()
    }
    
    func logout() {
        showAuth()
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    func didAuthenticate() {
        showMain()
    }
}
