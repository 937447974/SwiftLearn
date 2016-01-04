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
    func fetchAssetsWithOptions(options: PHFetchOptions?) -> [PHAsset] {
        var assets = [PHAsset]()
        let fetchResult = PHAsset.fetchAssetsInAssetCollection(self, options: options)
        fetchResult.enumerateObjectsUsingBlock { (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
            if let asset = obj as? PHAsset {
                assets.append(asset)
            }
        }
        return assets
    }
    
    // MARK: 存储照片
    /// 存储照片
    ///
    /// - parameter image: 图片
    ///
    /// - returns: void
    func creationAssetFromImage(image: UIImage, completionHandler: PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: dispatch_block_t = {
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            guard let placeholderForCreatedAsset = assetChangeRequest.placeholderForCreatedAsset else {
                // 照片生成出错
                print("PHAssetCollection \(__FUNCTION__)")
                return
            }
            guard let aCChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self) else {
                print("PHAssetCollection \(__FUNCTION__)")
                return
            }
            // 保存照片
            aCChangeRequest.addAssets([placeholderForCreatedAsset])
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: - 创建相薄
    /// 创建相薄
    ///
    /// - parameter title: 相薄名
    ///
    /// - returns: void
    class func creationWithTitle(title: String, completionHandler: PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: dispatch_block_t = {
            PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(title)
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: 修改专辑名
    /// 修改相薄名
    ///
    /// - parameter title: 相薄名
    ///
    /// - returns: void
    func renameLocalizedTitle(title: String, completionHandler: PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: dispatch_block_t = {
            let aCChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self)
            aCChangeRequest?.title = title
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: 删除PHAssetCollection
    /// 删除专辑
    ///
    /// - returns: void
    func deletes(completionHandler: PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: dispatch_block_t = {
            PHAssetCollectionChangeRequest.deleteAssetCollections([self])
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
}
