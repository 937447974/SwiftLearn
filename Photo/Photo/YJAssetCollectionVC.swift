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
    fileprivate var data = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard self.assectCollection != nil else {
            print("YJAssetCollectionVC.assectCollection未赋值")
            return
        }
        // 注册cell
        let nib = UINib(nibName: YJPhotoCollectionViewCellNibName, bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        PHPhotoLibrary.shared().register(self) // 监听照片库
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - 允许增加照片
    func allowAddPhoto() {
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(YJAssetCollectionVC.onClickAddPhoto))
    }
    
    // MARK: 增加照片
    func onClickAddPhoto() {
        let rect = CGRect(x: 0, y: 0, width: 400, height: 400)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        UIColor.green.setFill()
        UIRectFillUsingBlendMode(rect, CGBlendMode.normal)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.assectCollection.creationAssetFromImage(image!)
    }

    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print(#function)
        let changeDetails = changeInstance.changeDetails(for: self.assectCollection)
        if let assectCollection = changeDetails?.objectAfterChanges as? PHAssetCollection {
            // 修改数据源
            DispatchQueue.main.async { self.assectCollection = assectCollection}
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? YJAssetVC {
            vc.assetCollection = self.assectCollection // 相册
            let indexPath = sender as! IndexPath
            vc.asset = self.data[indexPath.item] // 相片
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! YJPhotoCollectionViewCell
        let asset = self.data[indexPath.item]
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image: UIImage?, info: [AnyHashable: Any]?) -> Void in
            cell.imageView.image = image
        })    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Asset", sender: indexPath)
    }
    
}
