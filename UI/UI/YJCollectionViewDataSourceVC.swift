//
//  YJCollectionViewDataSourceVC.swift
//  UI
//
//  Created by yangjun on 15/12/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UICollectionViewDataSource
class YJCollectionViewDataSourceVC: UIViewController, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UICollectionViewDataSource
    // MARK: 分组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print(__FUNCTION__)
        return 3
    }
    
    // MARK: 每一组有多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(__FUNCTION__)
        return 10
    }
    
    // MARK: 生成Cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print(__FUNCTION__)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.grayColor()
        if let label: UILabel = cell.viewWithTag(8) as? UILabel {
            label.text = "\(indexPath.row)"
            
        }
        return cell
    }
    
    
    // 生成Header或Footer
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        print(__FUNCTION__)
        var crView: UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) { // Header
            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            // 标题
            if let label: UILabel = crView.viewWithTag(8) as? UILabel {
                label.text = "\(indexPath.section) Section"
            }
            crView.backgroundColor = UIColor.redColor()
        } else { // Footer
            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
            crView.backgroundColor = UIColor.greenColor()
        }
        return crView
    }
    
    // MARK: 能否移动
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print(__FUNCTION__)
        return true
    }
    
    // MARK: 移动cell
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        print(__FUNCTION__)
        print(sourceIndexPath)
        print(destinationIndexPath)
    }

}
