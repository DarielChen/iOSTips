//
//  SecondViewController.swift
//  PluginTableView
//
//  Created by Dariel on 2019/8/7.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupTableViewBackground
        setUpTableView()
    }
    
    func setUpTableView() {
        
        let section = Section(items: [
            ENCellModel(name: "chili", imageStr: "chili"),
            ENCellModel(name: "mushroom", imageStr: "mushroom"),
            ENCellModel(name: "radish", imageStr: "radish")
            ])
        let dataSource = DataSource(sections: [section])
        
        let configuartor = Configurator{ (cell, model: ENCellModel, tableView, indexPath) -> NibTableViewCell in
            cell.iconLabel.text = model.name
            cell.iconView.image = UIImage(named: model.imageStr)
            return cell
        }
        
        let pluginTableView = PluginTableView(frame: view.bounds, style: .plain, dataSource: dataSource, configurator: configuartor)
        pluginTableView.tableView.tableFooterView = UIView()
        pluginTableView.tableView.rowHeight = 80
        view.addSubview(pluginTableView)
    }

}
