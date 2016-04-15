//
//  YJNSNotificationCenterVC.swift
//  YJFoundation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSNotificationCenter和NSNotification
class YJNSNotificationCenterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let nc = NSNotificationCenter.defaultCenter()
        // 注册通知
        nc.addObserver(self, selector: #selector(YJNSNotificationCenterVC.getNotification(_:)), name: "test", object: nil)
        // 会循环添加，无法删除，不推荐
        nc.addObserverForName("test", object: nil, queue: nil) { (notification: NSNotification) -> Void in
            print(notification.userInfo)
        }
        // 发出通知
        let notification = NSNotification(name: "test", object: nil, userInfo: ["name":"阳君", "qq":"937447974"])
        nc.postNotification(notification)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // 注销通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func getNotification(notification: NSNotification) {
        print(notification.name)
    }
    
}
