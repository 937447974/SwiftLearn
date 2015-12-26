//
//  PHAssetCollection+Extension.swift
//  Photo
//
//  Created by yangjun on 15/12/26.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos

extension PHAssetCollection {
    
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
    
}
