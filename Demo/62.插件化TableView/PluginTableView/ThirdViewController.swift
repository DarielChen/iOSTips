//
//  ThirdViewController.swift
//  PluginTableView
//
//  Created by Dariel on 2019/8/7.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupTableViewBackground
        setUpTableView()
    }
    
    func setUpTableView() {
        
        let section1 = Section<CellModel>(items: [
            .CNCell(CNCellModel(name: "柠檬", imageStr: "lemon")),
            .CNCell(CNCellModel(name: "橙子", imageStr: "orange")),
            .CNCell(CNCellModel(name: "西瓜", imageStr: "watermelon"))
            ])
        let section2 = Section<CellModel>(items: [
            .ENCell(ENCellModel(name: "chili", imageStr: "chili")),
            .ENCell(ENCellModel(name: "mushroom", imageStr: "mushroom")),
            .ENCell(ENCellModel(name: "radish", imageStr: "radish"))
            ])
        
        let dataSource = DataSource(sections: [section1, section2])

        let configuartor1 = Configurator { (cell, model: CNCellModel, tableView, indexPath) -> CodeTableViewCell in
            cell.iconLabel.text = model.name
            cell.iconView.image = UIImage(named: model.imageStr)
            return cell
        }
        
        let configuartor2 = Configurator { (cell, model: ENCellModel, tableView, indexPath) -> NibTableViewCell in
            cell.iconLabel.text = model.name
            cell.iconView.image = UIImage(named: model.imageStr)
            return cell
        }
        
        
        let aggregate = AggregateConfigurator(cellConfigurator1: configuartor1, cellConfigurator2: configuartor2)

        let pluginTableView = PluginTableView(frame: view.bounds, style: .grouped, dataSource: dataSource, configurator: aggregate)
        
        pluginTableView.tableView.tableFooterView = UIView()
        pluginTableView.tableView.rowHeight = 80
        view.addSubview(pluginTableView)
    }
}
private enum CellModel {
    case CNCell(CNCellModel)
    case ENCell(ENCellModel)
}

private struct AggregateConfigurator: ConfiguratorType {
    let cellConfigurator1: Configurator<CNCellModel, CodeTableViewCell>
    let cellConfigurator2: Configurator<ENCellModel, NibTableViewCell>
    
    func reuseIdentifier(for item: CellModel, indexPath: IndexPath) -> String {
        switch item {
        case .CNCell:
            return cellConfigurator1.reuseIdentifier
        case .ENCell:
            return cellConfigurator2.reuseIdentifier
        }
    }
    
    func configure(cell: UITableViewCell, item: CellModel, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        switch item {
        case .CNCell(let model):
            return cellConfigurator1.configuredCell(for: model, tableView: tableView, indexPath: indexPath)
        case .ENCell(let model):
            return cellConfigurator2.configuredCell(for: model, tableView: tableView, indexPath: indexPath)
        }
    }
    
    func registerCells(in tableView: UITableView) {
        cellConfigurator1.registerCells(in: tableView)
        cellConfigurator2.registerCells(in: tableView)
    }
}
