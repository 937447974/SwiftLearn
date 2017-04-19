//
//  PHAsset+Extension.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/4.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import Photos

/// PHAsset扩展
public extension PHAsset {
    
    // MARK: - 删除图片
    /// 删除图片
    ///
    /// - parameter assetCollection : PHAssetCollection?
    /// - parameter assetCollection : 执行回调
    ///
    /// - returns: void
    func deleteWithPHAssetCollection(_ assetCollection: PHAssetCollection?, completionHandler: @escaping PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: ()->() = {
            if assetCollection == nil { // 直接删除
                PHAssetChangeRequest.deleteAssets(Array(arrayLiteral: self) as NSFastEnumeration)
            } else if let changeRequest = PHAssetCollectionChangeRequest(for: assetCollection!) {
                // 从PHAssetCollection中删除
                changeRequest.removeAssets(Array(arrayLiteral: self) as NSFastEnumeration)
            }
        }
        PHPhotoLibrary.shared().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: - 收藏图片
    /// 收藏图片
    ///
    /// - parameter favorite : 是否收藏
    /// - parameter completionHandler : 执行完毕回调
    ///
    /// - returns: void
    func setFavorite(_ favorite: Bool, completionHandler: @escaping PHPhotoLibraryCompletionHandlerBlock = PHPhotoLibraryCompletionHandler) {
        let changeBlock: ()->() = {
            let request = PHAssetChangeRequest(for: self)
            request.isFavorite = favorite
        }
        PHPhotoLibrary.shared().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
}
