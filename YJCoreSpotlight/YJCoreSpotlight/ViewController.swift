//
//  ViewController.swift
//  YJCoreSpotlight
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/28.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard CSSearchableIndex.isIndexingAvailable() else {
            print("该设备不支持添加Spotlight搜索!")
            return
        }
        let sIndex = CSSearchableIndex.defaultSearchableIndex()
        // Delete all items.
        /*
        sIndex.deleteAllSearchableItemsWithCompletionHandler { (error: NSError?) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("Delete all items.")
            }
        }
        */
        // Create an item with a unique identifier, a domain identifier, and the attribute set you created earlier.
        var list = [CSSearchableItem]()
        for i in 0..<10 {
            // Create an attribute set to describe an item.
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeData as String)
            // Add metadata that supplies details about the item.
            attributeSet.title = "阳君\(i)"
            attributeSet.contentDescription = "姓名：阳君；QQ：937447974."
            attributeSet.keywords = ["yang", "阳"]
            attributeSet.thumbnailData = UIImagePNGRepresentation(UIImage(named: "qq")!)
            let item = CSSearchableItem(uniqueIdentifier: "\(i)", domainIdentifier: "file-1", attributeSet: attributeSet)
            list.append(item)
        }
        // Add the item to the on-device index.
        sIndex.indexSearchableItems(list) { (error: NSError?) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("Item indexed.")
            }
        }
  
    }
    
}

