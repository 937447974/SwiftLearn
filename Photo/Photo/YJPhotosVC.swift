//
//  YJPhotosVC.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/8.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos

/// 显示tag
private enum YJTag: Int {
    /// 时刻
    case All
    /// 精选
    case Cluster
    /// 年度
    case Year
}

/// 照片
class YJPhotosVC: UIViewController, UICollectionViewDataSource, PHPhotoLibraryChangeObserver {
    
    /// UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// 数据源
    private var data = [[PHAsset]]()
    /// section标题
    private var sectionHeaders = [String]()
    /// 当前显示Tag
    private var dataTag = YJTag.All
    /// 缓存工具
    private let cIManager = PHCachingImageManager()
    /// 从图片库中获取图片的大小
    private let targetSize = CGSize(width: 100, height: 100)
    
    // MARK: - viewDid
    override func viewDidLoad() {
        super.viewDidLoad()
        // 右按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "onSearch")
        // 注册cell
        let nib = UINib(nibName: YJPhotoCollectionViewCellNibName, bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "photoCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
        // 监听设备方向
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedRotation",
            name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - NSNotificationCenter
    // 通知监听触发的方法
    func receivedRotation() {
        // 修改collectionView约束
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            var count: CGFloat = 0
            switch self.dataTag {
            case .All: // 时刻
                count = 5
                flowLayout.minimumLineSpacing = 10
            case .Cluster: // 精选
                count = 8
                flowLayout.minimumLineSpacing = 5
            case .Year: // 年度
                count = 10
                flowLayout.minimumLineSpacing = 0
            }
            flowLayout.minimumInteritemSpacing = flowLayout.minimumLineSpacing
            flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
            let width = (self.collectionView.bounds.size.width - 10 - flowLayout.minimumLineSpacing * (count-1)) / count
            flowLayout.itemSize = CGSize(width: width, height: width)
        }
        // 刷新UI
        self.collectionView.reloadData()
    }
    
    // MARK: - 刷新数据
    private func reloadData() {
        // 获取照片
        var fetchResult: PHFetchResult!
        switch self.dataTag {
        case .All: // 时刻
            fetchResult = PHAssetCollection.fetchMomentsWithOptions(nil)
        case .Cluster: // 精选
            fetchResult = PHCollectionList.fetchMomentListsWithSubtype(PHCollectionListSubtype.MomentListCluster, options: nil)
        case .Year: // 年度
            fetchResult = PHCollectionList.fetchMomentListsWithSubtype(PHCollectionListSubtype.MomentListYear, options: nil)
        }
        // 数据源处理
        self.data.removeAll()
        self.sectionHeaders.removeAll()
        fetchResult.enumerateObjectsUsingBlock { (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
            var assets = [PHAsset]()
            if let assetCollection = obj as? PHAssetCollection {
                assets = assetCollection.fetchAssetsWithOptions(nil)
            } else if let collectionList = obj as? PHCollectionList {
                assets = collectionList.fetchAssetsWithOptions(nil)
            }
            if assets.count != 0 {
                self.data.append(assets)
                self.sectionHeaders.append(obj.localizedTitle)
                // 缓存照片
                self.cIManager.startCachingImagesForAssets(assets, targetSize: self.targetSize, contentMode: PHImageContentMode.Default, options: nil)
            }
        }
        self.receivedRotation()
    }
    
    // MARK: - Action
    func onSearch() {
        let alertController = UIAlertController(title: "照片", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.addAction(UIAlertAction(title: "时刻", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.dataTag = YJTag.All
            self.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "精选", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.dataTag = YJTag.Cluster
            self.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "年度", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.dataTag = YJTag.Year
            self.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        if YJUtilUserInterfaceIdiom.isPad {
            let popPresenter = alertController.popoverPresentationController
            popPresenter?.sourceView = self.view
            popPresenter?.sourceRect = CGRect(x: 150, y: 150, width: 200, height: 500)
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        self.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! YJPhotoCollectionViewCell
        let asset = self.data[indexPath.section][indexPath.item]
        self.cIManager.requestImageForAsset(asset, targetSize: self.targetSize, contentMode: PHImageContentMode.Default, options: nil, resultHandler: { (image: UIImage?, info: [NSObject : AnyObject]?) -> Void in
            cell.imageView.image = image
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var crView: UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) { // Header
            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            // 标题
            if let label: UILabel = crView.viewWithTag(8) as? UILabel {
                label.text = "\(self.sectionHeaders[indexPath.section])(\(self.data[indexPath.section].count))"
            }
        }
        return crView
    }
    
}
