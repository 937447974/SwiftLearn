//
//  YJNSBundleResourceRequestVC.swift
//  YJFoundation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSBundleResourceRequest
class YJNSBundleResourceRequestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tags = Set(arrayLiteral: "image")
        let brRequest = NSBundleResourceRequest(tags: tags)
        brRequest.conditionallyBeginAccessingResources { (success:Bool) -> Void in
            guard success else { // 开始下载
                brRequest.beginAccessingResources(completionHandler: { (error: NSError?) -> Void in
                    guard error == nil else {
                        print("下载错误:\(error)")
                        return
                    }
                    print("开始下载")
                    // 下载进度
                    brRequest.progress.addObserver(self, forKeyPath: "fractionCompleted", options: NSKeyValueObservingOptions.new, context: nil)
                } as! (Error?) -> Void)
                return
            }
            print("已下载")
        }
        
        // 低存储空间警告
        NotificationCenter.default.addObserver(self, selector: #selector(YJNSBundleResourceRequestVC.lowDiskSpace(_:)), name: NSNotification.Name.NSBundleResourceRequestLowDiskSpace, object: nil)
    }
    
    // MARK: 低内存警告
    func lowDiskSpace(_ notification: Notification) {
        print(#function)
    }
    
    // MARK: KVO监听加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(change)
    }

}
