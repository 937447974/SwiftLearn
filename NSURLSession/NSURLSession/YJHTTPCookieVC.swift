//
//  YJHTTPCookieVC.swift
//  NSURLSession
//
//  Created by yangjun on 15/12/5.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// NSHTTPCookie
class YJHTTPCookieVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 共享cookie
        let sharedHTTPCookie = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        // 手动创建一个cookie
        var dict = [String : AnyObject]()
        dict[NSHTTPCookieName] = "阳君"
        dict[NSHTTPCookieValue] = "937447974"
        dict[NSHTTPCookieVersion] = 1
        dict[NSHTTPCookieDomain] = "blog.csdn.net"
        dict[NSHTTPCookiePath] = "/"
        if let cookie = NSHTTPCookie(properties: dict) {
            print("手动创建\(cookie.properties)")
            sharedHTTPCookie.setCookie(cookie)
        }
        
        // 删除所有
        if let list = sharedHTTPCookie.cookies {
            // 获取cookie的header
            print(NSHTTPCookie.requestHeaderFieldsWithCookies(list))
            for cookie in list {
                // 读取cookie
                print(cookie.properties)
                // 删除cookie
                sharedHTTPCookie.deleteCookie(cookie)
            }
        }
    }

}
