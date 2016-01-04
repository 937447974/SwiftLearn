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
    func deleteWithPHAssetCollection(assetCollection: PHAssetCollection?, completionHandler: PHPhotoLibraryCompletionHandlerBlock = PHAssetCompletionHandler) {
        let changeBlock: dispatch_block_t = {
            if assetCollection == nil { // 直接删除
                PHAssetChangeRequest.deleteAssets([self])
            } else if let changeRequest = PHAssetCollectionChangeRequest(forAssetCollection: assetCollection!) {
                // 从PHAssetCollection中删除
                changeRequest.removeAssets([self])
            }
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
}


