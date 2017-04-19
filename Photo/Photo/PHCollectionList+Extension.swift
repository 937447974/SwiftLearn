//
//  PHCollectionList+Extension.swift
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

public extension PHCollectionList {
    
    /// 获取PHAsset集合
    ///
    /// - parameter options : PHFetchOptions?
    ///
    /// - returns: [PHAsset]
    func fetchAssetsWithOptions(_ options: PHFetchOptions?) -> [PHAsset] {
        var assets = [PHAsset]()
        let fetchResult = PHAssetCollection.fetchMoments(inMomentList: self, options: options)
        fetchResult.enumerateObjects({ (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
            if let assetCollection = obj as? PHAssetCollection {
                assets.append(contentsOf: assetCollection.fetchAssetsWithOptions(options))
            }
        })
        return assets
    }
    
}

