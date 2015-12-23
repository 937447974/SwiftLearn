//
//  YJCollectionViewDelegateFlowLayoutVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/21.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UICollectionViewDelegateFlowLayout
class YJCollectionViewDelegateFlowLayoutVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
        // 长点击事件，做移动cell操作
        self.collectionView.allowsMoveItem()
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.grayColor()
        if let label: UILabel = cell.viewWithTag(8) as? UILabel {
            label.text = "\(indexPath.item)"
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var crView: UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) { // Header
            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            // 标题
            if let label: UILabel = crView.viewWithTag(8) as? UILabel {
                label.text = "\(indexPath.section) Section"
            }
            crView.backgroundColor = UIColor.orangeColor()
        } else { // Footer
            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
            crView.backgroundColor = UIColor.purpleColor()
        }
        return crView
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    // MARK: - Getting the Size of Items
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        print(__FUNCTION__)
        // 每一行显示5个
        let weight = (YJUtilScreenSize.screenMinLength-10*5)/4
        return CGSize(width: weight, height: weight)
    }
    
    // MARK: - Getting the Section Spacing
    // MARK: 边间隔
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        print(__FUNCTION__)
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // MARK: 行间隔
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        print(__FUNCTION__)
        return 10
    }
    
    // MARK: 列间隔
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        print(__FUNCTION__)
        return 10
    }
    
    // MARK: - Getting the Header and Footer Sizes
    // MARK: Header显示
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        print(__FUNCTION__)
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    // MARK: Footer显示
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        print(__FUNCTION__)
        return CGSize(width: collectionView.frame.width, height: 50)
    }

}
