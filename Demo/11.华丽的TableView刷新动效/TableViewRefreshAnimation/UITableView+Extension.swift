//
//  UITableView+Extension.swift
//  TableViewRefreshAnimation
//
//  Created by Dariel on 2018/10/12.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}

