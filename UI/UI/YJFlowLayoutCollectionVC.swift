//
//  YJFlowLayoutCollectionVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/22.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

private let reuseIdentifier = "customCell"

/// 自定义UICollectionViewFlowLayout
class YJFlowLayoutCollectionVC: UICollectionViewController, YJCollectionViewDelegateFlowLayout {
    
    /// 数据源
    private var data = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 测试数据
        for _ in 0...2 {
            var list = [Int]()
            for i in 0..<50 {
                list.append(i)
            }
            self.data.append(list)
        }
        // 修改YJCollectionViewFlowLayout
        let layout = self.collectionView!.collectionViewLayout as! YJCollectionViewFlowLayout
        layout.headerReferenceHeight = 60
        layout.footerReferenceHeight = 50
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        switch UIDevice.currentDevice().orientation{
        case .LandscapeLeft, .LandscapeRight:
            layout.sectionItems = [[0], [1,7], [2,8], [3,9], [4,10], [5,11], [6,12]]
        default:
            layout.sectionItems = [[0], [1,5], [2,6],[3,7],[4,8]]
        }
        // 监听设备方向
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YJFlowLayoutCollectionVC.receivedRotation),
            name: UIDeviceOrientationDidChangeNotification, object: nil)
        // 注册Cell
        let nib = UINib(nibName: "YJCollectionViewCell", bundle: nil)
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    //通知监听触发的方法
    func receivedRotation(){
        let device = UIDevice.currentDevice()
        let layout = self.collectionView!.collectionViewLayout as! YJCollectionViewFlowLayout
        switch device.orientation{
        case UIDeviceOrientation.Portrait, UIDeviceOrientation.PortraitUpsideDown:
            layout.sectionItems = [[0], [1,5], [2,6],[3,7],[4,8]]
        case .LandscapeLeft, .LandscapeRight:
            layout.sectionItems = [[0], [1,7], [2,8], [3,9], [4,10], [5,11], [6,12]]
        default:
            print(device.orientation)
        }
    }
    
    // MARK: - YJCollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewFlowLayout: YJCollectionViewFlowLayout, widthForSectionAtColumn column: Int) -> CGFloat {
        // 如一行显示3个间隔设置为10，则公式为(2width+10)+2width+20 = collectionView.bounds.size.width - sectionInset.left - sectionInset.right
        let sectionItemCount: CGFloat = CGFloat(collectionViewFlowLayout.sectionItems.count)
        let width = (collectionView.bounds.size.width - collectionViewFlowLayout.sectionInset.left - collectionViewFlowLayout.sectionInset.right - (sectionItemCount-1)*10) / (sectionItemCount+1)
        if column == 0 {
            return 2 * width + 10
        }
        return width
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewFlowLayout: YJCollectionViewFlowLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let sectionItemCount: CGFloat = CGFloat(collectionViewFlowLayout.sectionItems.count)
        let height = (collectionView.bounds.size.width - collectionViewFlowLayout.sectionInset.left - collectionViewFlowLayout.sectionInset.right - (sectionItemCount-1)*10) / (sectionItemCount+1)
        if indexPath.row % collectionViewFlowLayout.sectionItemsCount == 0 {
            return 2 * height + 10
        }
        return height
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! YJCollectionViewCell
        cell.backgroundColor = UIColor.grayColor()
        cell.textLabel.text = "\(indexPath.item)"
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
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
    
}
