//
//  MessageCoordinator.swift
//  CoordinateDemo
//
//  Created by Dariel on 2019/5/29.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

final class MessageCoordinator: Coordinator {
    
    private let navController: UINavigationController

    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let messageVc = MessageViewController()
        messageVc.delegate = self
        navController.pushViewController(messageVc, animated: true)
    }
    
    private func toDetailMessageVc() {
        let messageDetailVc = MessageDetailController()
        navController.pushViewController(messageDetailVc, animated: true)
    }
}


extension MessageCoordinator: MessageViewControllerDelegate  {
    func toDetailMessage() {
        toDetailMessageVc()
    }
}
