//
//  ViewController.swift
//  PluginTableView
//
//  Created by Dariel on 2019/8/6.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpTableView()
    }
    
    func setUpTableView() {
        
        let section = Section(items: ["1.纯代码创建Cell", "2.Xib创建Cell", "3.不同类型cell分组"])
        let dataSource = DataSource(sections: [section])
        
        let configuartor = Configurator{ (cell, model: String, tableView, indexPath) -> UITableViewCell in
            cell.textLabel?.text = model
            return cell
        }
        
        let pluginTableView = PluginTableView(frame: view.bounds, style: .plain, dataSource: dataSource, configurator: configuartor)
        pluginTableView.tableView.tableFooterView = UIView()
        view.addSubview(pluginTableView)
        
        pluginTableView.didSelectRow = { [weak self] (tableView, indexPath) in
            
            switch indexPath.row {
                
            case 0:
                self?.navigationController?.pushViewController(FirstViewController(), animated: true)
                break
            case 1:
                self?.navigationController?.pushViewController(SecondViewController(), animated: true)
                break
            case 2:
                self?.navigationController?.pushViewController(ThirdViewController(), animated: true)
                break
            default:
                break
            }
        }
    }
}
