//
//  UITableView+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2019/3/19.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

extension UITableView {
    /// 添加空白页
    ///
    /// - Parameter message: 空白页文字
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.textAlignment = .center
        label.sizeToFit()
        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
    /// 删除空白页
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
