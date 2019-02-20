//
//  CustomActionsheetController.swift
//  CustomPresentation
//
//  Created by Dariel on 2019/2/19.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit


class CustomActionsheetController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "标题"
        
        let messageLabel = UILabel()
        messageLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        messageLabel.font = .systemFont(ofSize: 18, weight: .medium)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = "内容可以很长，可以支持多行文本"
        
        let connectButton = UIButton(type: .system)
        connectButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        connectButton.setTitle("确认", for: .normal)
        connectButton.addTarget(self, action: #selector(presentConnection), for: .primaryActionTriggered)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.addTarget(self, action: #selector(close), for: .primaryActionTriggered)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel, connectButton, cancelButton])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            ])
    }
    
    @objc private func presentConnection() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(close))
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.navigationItem.rightBarButtonItem = closeButton
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}

extension CustomActionsheetController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CardPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class CardPresentationController: PresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return containerView.bounds
            .inset(by: UIEdgeInsets(top: containerView.bounds.height - 300, left: 16, bottom: 16, right: 16))
            .inset(by: containerView.safeAreaInsets)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        presentedView?.layer.cornerRadius = 24
        containerView?.backgroundColor = .clear
        
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = .clear
                }, completion: nil)
        }
    }
}
