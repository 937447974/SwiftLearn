//
//  User.swift
//  KVC
//
//  Created by yangjun on 15/10/10.
//  Copyright © 2015年 六月. All rights reserved.
//

import Foundation

/// 用户
class User: NSObject {
    
    /// 用户名
    dynamic var userName:String?
    
    override init() {
        userName = ""
    }
    
}
