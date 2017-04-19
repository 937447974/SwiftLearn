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
    case all
    /// 精选
    case cluster
    /// 年度
    case year
}

/// 照片
class YJPhotosVC: UIViewController, UICollectionViewDataSource, PHPhotoLibraryChangeObserver {
    
    /// UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// 数据源
    fileprivate var data = [[PHAsset]]()
    /// section标题
    fileprivate var sectionHeaders = [String]()
    /// 当前显示Tag
    fileprivate var dataTag = YJTag.all
    /// 缓存工具
    fileprivate let cIManager = PHCachingImageManager()
    /// 从图片库中获取图片的大小
    fileprivate let targetSize = CGSize(width: 200, height: 200)
    
    // MARK: - viewDid
    override func viewDidLoad() {
        super.viewDidLoad()
        // 右按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(YJPhotosVC.onSearch(_:)))
        // 注册cell
        let nib = UINib(nibName: YJPhotoCollectionViewCellNibName, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "photoCell")
        // 照片库监听
        PHPhotoLibrary.shared().register(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        // 监听设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(YJPhotosVC.receivedRotation),
            name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        self.tabBarController?.tabBar.isHidden = true
    }

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - NSNotificationCenter
    // 通知监听触发的方法
    func receivedRotation() {
        // 修改collectionView约束
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            var count: CGFloat = 0
            switch self.dataTag {
            case .all: // 时刻
                count = 5
                flowLayout.minimumLineSpacing = 10
            case .cluster: // 精选
                count = 8
                flowLayout.minimumLineSpacing = 5
            case .year: // 年度
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
    fileprivate func reloadData() {
        // 获取照片
        var fetchResult: PHFetchResult<PHCollection>!
        switch self.dataTag {
        case .all: // 时刻
            fetchResult = PHAssetCollection.fetchMoments(with: nil) as! PHFetchResult<PHCollection>
        case .cluster: // 精选
            fetchResult = PHCollectionList.fetchMomentLists(with: PHCollectionListSubtype.momentListCluster, options: nil) as! PHFetchResult<PHCollection>
        case .year: // 年度
            fetchResult = PHCollectionList.fetchMomentLists(with: PHCollectionListSubtype.momentListYear, options: nil) as! PHFetchResult<PHCollection>
        }
        // 数据源处理
        self.data.removeAll()
        self.sectionHeaders.removeAll()
        fetchResult.enumerateObjects({ (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
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
                self.cIManager.startCachingImages(for: assets, targetSize: self.targetSize, contentMode: PHImageContentMode.aspectFill, options: nil)
            }
        })
        self.receivedRotation()
    }
    
    // MARK: - Action
    func onSearch(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "照片", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "时刻", style: .default, handler: { (action: UIAlertAction) -> Void in
            self.dataTag = YJTag.all
            self.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "精选", style: .default, handler: { (action: UIAlertAction) -> Void in
            self.dataTag = YJTag.cluster
            self.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "年度", style: .default, handler: { (action: UIAlertAction) -> Void in
            self.dataTag = YJTag.year
            self.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        if YJUtilUserInterfaceIdiom.isPad {
            alertController.modalPresentationStyle = UIModalPresentationStyle.popover;
            alertController.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem;
            alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up;
//            let popPresenter = alertController.popoverPresentationController
//            popPresenter?.sourceView = self.view
//            popPresenter?.sourceRect = CGRect(x: 150, y: 150, width: 200, height: 500)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        self.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! YJPhotoCollectionViewCell
        let asset = self.data[indexPath.section][indexPath.item]
        self.cIManager.requestImage(for: asset, targetSize: self.targetSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image: UIImage?, info: [AnyHashable: Any]?) -> Void in
            cell.imageView.image = image
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var crView: UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) { // Header
            crView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            // 标题
            if let label: UILabel = crView.viewWithTag(8) as? UILabel {
                label.text = "\(self.sectionHeaders[indexPath.section])(\(self.data[indexPath.section].count))"
            }
        }
        return crView
    }
    
}
