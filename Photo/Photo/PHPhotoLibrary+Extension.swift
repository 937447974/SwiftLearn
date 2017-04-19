//
//  PHPhotoLibrary+Extension.swift
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

/// performChanges(changeBlock: dispatch_block_t, completionHandler: ((Bool, Error?) -> Void)?)的完成回调
public typealias PHPhotoLibraryCompletionHandlerBlock = (Bool, Error?) -> Void

/// CompletionHandler输出
public let PHPhotoLibraryCompletionHandler: PHPhotoLibraryCompletionHandlerBlock = { (success: Bool, error: Error?) -> Void in
    if !success {
        print(error!)
    }
}

