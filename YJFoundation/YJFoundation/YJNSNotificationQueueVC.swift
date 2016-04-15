//
//  YJNSNotificationQueueVC.swift
//  YJFoundation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSNotificationQueue
class YJNSNotificationQueueVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YJNSNotificationQueueVC.getNotification(_:)), name: "test", object: nil)
        // 队列发出通知
        let notification = NSNotification(name: "test", object: nil, userInfo: ["name":"阳君", "qq":"937447974"])
        NSNotificationQueue.defaultQueue().enqueueNotification(notification, postingStyle: NSPostingStyle.PostWhenIdle)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // 注销通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func getNotification(notification: NSNotification) {
        print(notification.userInfo)
    }
    
}
