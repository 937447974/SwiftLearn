//
//  ViewController.swift
//  YJAccounts
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/25.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import Accounts

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let completion = { (success: Bool, error: NSError!) -> Void in
            print("权限认证success: \(success), error: \(error)")
        }
        let accountStore = ACAccountStore()
        accountStore.requestSinaWeiboAccess(completion)
    }
    
}

