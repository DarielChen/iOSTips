//
//  ViewController.swift
//  EditingCollectionView
//
//  Created by Dariel on 2019/1/8.
//  Copyright © 2019年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellIdentifier = "cell"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.pinEdgesToSuperView()
    }
        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 4, right: 0)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    var items: [String] = {
        var items = [String]()
        for i in 1 ..< 20 {
            items.append("Item \(i)")
        }
        return items
    }()
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.itemNameLabel.text = items[indexPath.item]
        cell.delegate = self
        return cell
    }
}

extension ViewController: EditableCollectionViewCellDelegate {
    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        items.remove(at: indexPath.item)
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
        })
    }
}
