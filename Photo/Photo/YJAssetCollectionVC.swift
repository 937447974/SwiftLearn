//
//  YJAssetCollectionVC.swift
//  Photo
//
//  Created by yangjun on 15/12/28.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "photoCell"

/// 相册
class YJAssetCollectionVC: UICollectionViewController, PHPhotoLibraryChangeObserver {
    
    /// PHAssetCollection集合
    var assectCollection: PHAssetCollection! {
        didSet {
            self.data = assectCollection.fetchAssetsWithOptions(nil)
            self.collectionView!.reloadData()
        }
    }
    /// 数据源
    private var data = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard self.assectCollection != nil else {
            print("YJAssetCollectionVC.assectCollection未赋值")
            return
        }
        // 注册cell
        let nib = UINib(nibName: YJPhotoCollectionViewCellNibName, bundle: nil)
        self.collectionView!.registerNib(nib, forCellWithReuseIdentifier: reuseIdentifier)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self) // 监听照片库
    }
    
    deinit {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
    
    // MARK: - 允许增加照片
    func allowAddPhoto() {
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClickAddPhoto")
    }
    
    // MARK: 增加照片
    func onClickAddPhoto() {
        let rect = CGRect(x: 0, y: 0, width: 400, height: 400)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        UIColor.greenColor().setFill()
        UIRectFillUsingBlendMode(rect, CGBlendMode.Normal)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.assectCollection.creationAssetFromImage(image)
    }

    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        print(__FUNCTION__)
        let changeDetails = changeInstance.changeDetailsForObject(self.assectCollection)
        if let assectCollection = changeDetails?.objectAfterChanges as? PHAssetCollection {
            // 修改数据源
            dispatch_async(dispatch_get_main_queue()) { self.assectCollection = assectCollection}
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? YJAssetVC {
            vc.assetCollection = self.assectCollection // 相册
            let indexPath = sender as! NSIndexPath
            vc.asset = self.data[indexPath.item] // 相片
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! YJPhotoCollectionViewCell
        let asset = self.data[indexPath.item]
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSize(width: 100, height: 100), contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image: UIImage?, info: [NSObject : AnyObject]?) -> Void in
            cell.imageView.image = image
        })    
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("Asset", sender: indexPath)
    }
    
}
