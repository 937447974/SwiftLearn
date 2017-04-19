//
//  PHAssetCollection+Extension.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/26.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos

/// PHAssetCollection扩展
public extension PHAssetCollection {
    
    // MARK: - 获取PHAsset集合
    /// 获取PHAsset集合
    ///
    /// - parameter options : PHFetchOptions?
    ///
    /// - returns: [PHAsset]
    func fetchAssetsWithOptions(_ options: PHFetchOptions?) -> [PHAsset] {
        var assets = [PHAsset]()
        let fetchResult = PHAsset.fetchAssets(in: self, options: options)
        fetchResult.enumerateObjects({ (asset, index, umPointer) in
            assets.append(asset)
        })
        return assets
    }
    
    // MARK: 存储照片
    /// 存储照片
    ///
    /// - parameter image: 图片
    ///
    /// - returns: void
    func creationAssetFromImage(_ image: UIImage, completionHandler: @escaping PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: ()->() = {
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            guard let placeholderForCreatedAsset = assetChangeRequest.placeholderForCreatedAsset else {
                // 照片生成出错
                print("PHAssetCollection \(#function)")
                return
            }
            guard let aCChangeRequest = PHAssetCollectionChangeRequest(for: self) else {
                print("PHAssetCollection \(#function)")
                return
            }
            // 保存照片
            aCChangeRequest.addAssets([placeholderForCreatedAsset] as NSFastEnumeration)
        }
        PHPhotoLibrary.shared().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: - 创建相薄
    /// 创建相薄
    ///
    /// - parameter title: 相薄名
    ///
    /// - returns: void
    class func creationWithTitle(_ title: String, completionHandler: @escaping PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: ()->() = {
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
        }
        PHPhotoLibrary.shared().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: 修改专辑名
    /// 修改相薄名
    ///
    /// - parameter title: 相薄名
    ///
    /// - returns: void
    func renameLocalizedTitle(_ title: String, completionHandler: @escaping PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: ()->() = {
            let aCChangeRequest = PHAssetCollectionChangeRequest(for: self)
            aCChangeRequest?.title = title
        }
        PHPhotoLibrary.shared().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: 删除PHAssetCollection
    /// 删除专辑
    ///
    /// - returns: void
    func deletes(_ completionHandler: @escaping PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: ()->() = {
            PHAssetCollectionChangeRequest.deleteAssetCollections([self] as NSFastEnumeration)
        }
        PHPhotoLibrary.shared().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
}
