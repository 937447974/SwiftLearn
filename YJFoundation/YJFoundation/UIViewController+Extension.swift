//
//  UIViewController+Extension.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UIViewController扩展
public extension UIViewController {

    // MARK: - push跳转Storyboard
    /// push跳转到Storyboard
    ///
    /// - parameter storyboardName : 故事面板名
    /// - parameter sender : 处理携带参数
    ///
    /// - returns: void
    func pushStoryboard(_ storyboardName: String, sender: ((UIViewController) -> Void)?) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil) // 1 获取UIStoryboard
        var vc = storyboard.instantiateInitialViewController() // 2.1 入口为UIViewController
        if let nc = vc as? UINavigationController { // 2.2 入口为UINavigationController
            vc = nc.topViewController
        }
        sender?(vc!) // 3 数据处理
        self.navigationController?.pushViewController(vc!, animated: true) // 4跳转
    }
    
    // MARK: push跳转到Storyboard中指定UIViewController
    /// push跳转到Storyboard中指定UIViewController
    ///
    /// - parameter storyboardName : 故事面板名
    /// - parameter identifier : 定位UIViewController的标示符
    /// - parameter sender : 处理携带参数
    ///
    /// - returns: void
    func pushStoryboard(_ storyboardName: String, identifier: String, sender: ((UIViewController) -> Void)?) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        sender?(vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
