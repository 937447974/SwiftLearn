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
    var assectCollection: PHAssetCollection!
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
        self.data = self.assectCollection.fetchAssetsWithOptions(nil)
    }
    
    deinit {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }

    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        print(__FUNCTION__)
        if let changeDetails = changeInstance.changeDetailsForObject(self.assectCollection) {
            // 修改数据源
            self.assectCollection = changeDetails.objectAfterChanges as! PHAssetCollection
            self.data = self.assectCollection.fetchAssetsWithOptions(nil)
            // 刷新UI
            dispatch_async(dispatch_get_main_queue()) { self.collectionView!.reloadData() }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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

}
