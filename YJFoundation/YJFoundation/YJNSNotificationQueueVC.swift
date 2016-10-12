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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(YJNSNotificationQueueVC.getNotification(_:)), name: NSNotification.Name(rawValue: "test"), object: nil)
        // 队列发出通知
        let notification = Notification(name: Notification.Name(rawValue: "test"), object: nil, userInfo: ["name":"阳君", "qq":"937447974"])
        NotificationQueue.default.enqueue(notification, postingStyle: NotificationQueue.PostingStyle.whenIdle)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    func getNotification(_ notification: Notification) {
        print((notification as NSNotification).userInfo)
    }
    
}
