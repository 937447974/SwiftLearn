//
//  YJPreviewItem.swift
//  YJQuickLook
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/24.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import QuickLook

/// 文件QLPreviewItem
class YJPreviewItem: NSObject, QLPreviewItem {
    
    var previewItemURL: NSURL {
        return  NSBundle.mainBundle().URLForResource("Test", withExtension: "pdf")!
    }
    
    var previewItemTitle: String? {
        return "Title"
    }
    
}
