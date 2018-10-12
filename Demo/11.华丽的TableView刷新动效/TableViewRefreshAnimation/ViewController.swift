//
//  ViewController.swift
//  TableViewRefreshAnimation
//
//  Created by Dariel on 2018/10/12.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

enum Animator {
    case makeFade
    case makeMoveUpWithBounce
    case makeSlideIn
    case makeMoveUpWithFade
}

class ViewController: UITableViewController {

    var animator = Animator.makeFade

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch animator {
        case .makeFade:
            let animation = AnimationFactory.makeFade(duration: 0.5, delayFactor: 0.05)
            let animator = TableViewAnimator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)

        case .makeMoveUpWithBounce:
            let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
            let animator = TableViewAnimator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)

        case .makeSlideIn:
            let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
            let animator = TableViewAnimator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)

        case .makeMoveUpWithFade:
            let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
            let animator = TableViewAnimator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
        }
        
    }
    
    @IBAction func makeFadeTouch(_ sender: Any) {
        animator = .makeFade
        tableView.reloadData()
    }
    
    @IBAction func makeMoveUpWithBounce(_ sender: Any) {
        animator = .makeMoveUpWithBounce
        tableView.reloadData()
    }
    
    
    @IBAction func makeSlideInTouch(_ sender: Any) {
        animator = .makeSlideIn
        tableView.reloadData()
    }
    
    @IBAction func makeMoveUpWithFadeTouch(_ sender: Any) {
        animator = .makeMoveUpWithFade
        tableView.reloadData()
    }
    
}

