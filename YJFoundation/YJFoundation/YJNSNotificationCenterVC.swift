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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let nc = NotificationCenter.default
        // 注册通知
        nc.addObserver(self, selector: #selector(YJNSNotificationCenterVC.getNotification(_:)), name: NSNotification.Name(rawValue: "test"), object: nil)
        // 会循环添加，无法删除，不推荐
        nc.addObserver(forName: NSNotification.Name(rawValue: "test"), object: nil, queue: nil) { (notification: Notification) -> Void in
            print((notification as NSNotification).userInfo)
        }
        // 发出通知
        let notification = Notification(name: Notification.Name(rawValue: "test"), object: nil, userInfo: ["name":"阳君", "qq":"937447974"])
        nc.post(notification)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    func getNotification(_ notification: Notification) {
        print(notification.name)
    }
    
}
