//
//  YJCollectionViewDataSourceVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UICollectionViewDataSource
class YJCollectionViewDataSourceVC: UIViewController, UICollectionViewDataSource {

    /// UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// 数据源
    private var data = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 测试数据
        for _ in 0...2 {
            var list = [Int]()
            for i in 0..<10 {
                list.append(i)
            }
            self.data.append(list)
        }
        // 使用手势移动Cell
        self.collectionView.allowsMoveItem()
    }
    
    // MARK: - UICollectionViewDataSource
    // MARK: 分组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    // MARK: 每一组有多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    // MARK: - Getting Views for Items
    // MARK: 生成Cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.grayColor()
        if let label: UILabel = cell.viewWithTag(8) as? UILabel {
            label.text = "\(indexPath.item)"
        }
        return cell
    }
    
    // MARK: 生成Header或Footer
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        print(#function)
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
    
    // MARK: - Reordering Items
    // MARK: 能否移动
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print(#function)
        return true
    }
    
    // MARK: 移动cell结束
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        print(#function)
        print(sourceIndexPath)
        print(destinationIndexPath)
        // 修改数据源
        let temp = self.data[sourceIndexPath.section].removeAtIndex(sourceIndexPath.item)
        self.data[destinationIndexPath.section].insert(temp, atIndex: destinationIndexPath.item)
        print(self.data)
    }

}
