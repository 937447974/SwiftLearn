//
//  YJCollectionViewDataSourceVC.swift
//  UI
//
//  Created by yangjun on 15/12/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UICollectionViewDataSource
class YJCollectionViewDataSourceVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let cell = UICollectionViewCell(frame: CGRectMake(0, 0, 20, 20))
//        self.collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        let nib = UINib(nibName: "YJCollectionViewCell", bundle: nil)
//                self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: "cell")
//        
//        self.clearsSelectionOnViewWillAppear = false
//        self.collectionView?.contentSize = CGSizeMake(100, 100)
//        self.collectionView?.collectionViewLayout
//        print(self.collectionView)
    }

    // MARK: - UICollectionViewDataSource
    // MARK: 分组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // MARK: 每一组有多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    // MARK: 生成Cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    
    // 生成Header或Footer
//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        var crView: UICollectionReusableView!
//        if (kind == UICollectionElementKindSectionHeader) { //
//            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
//            // 标题
//            let label:UILabel? = crView.viewWithTag(8) as? UILabel
//            label?.text = "group"
//        } else {
//            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
//        }
//        return crView
//    }
    
    // MARK: 能否移动
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print(__FUNCTION__)
        return true
    }
    
    // MARK: 移动cell
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        print(sourceIndexPath)
        print(destinationIndexPath)
    }

}
