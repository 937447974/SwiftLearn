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
        let sharedHTTPCookie = HTTPCookieStorage.shared
        
        // 手动创建一个cookie
        var dict = [HTTPCookiePropertyKey : Any]()
        dict[HTTPCookiePropertyKey.name] = "阳君"
        dict[HTTPCookiePropertyKey.value] = "937447974"
        dict[HTTPCookiePropertyKey.version] = 1
        dict[HTTPCookiePropertyKey.domain] = "blog.csdn.net"
        dict[HTTPCookiePropertyKey.path] = "/"
        if let cookie = HTTPCookie(properties: dict) {
            print("手动创建\(cookie.properties ?? [:])")
            sharedHTTPCookie.setCookie(cookie)
        }
        
        // 删除所有
        if let list = sharedHTTPCookie.cookies {
            // 获取cookie的header
            print(HTTPCookie.requestHeaderFields(with: list))
            for cookie in list {
                // 读取cookie
                print(cookie.properties ?? [:])
                // 删除cookie
                sharedHTTPCookie.deleteCookie(cookie)
            }
        }
    }

}
