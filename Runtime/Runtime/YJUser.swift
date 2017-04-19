//
//  YJUser.swift
//  Runtime
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/11.
//  Copyright © 2016年 阳君. All rights reserved.
//

import Cocoa

/// 用户
class YJUser: NSObject {
    
}

/// 扩展
extension YJUser {
    
    /// 用户名
    var name: String? {
        get {
            return objc_getAssociatedObject(self, "_name") as? String
        }
        set {
            objc_setAssociatedObject(self, "_name", newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 清空所有关联属性
    ///
    /// - returns: void
    func cleanParameter() {
        // 此时再获取关联属性的值，会报错
        objc_removeAssociatedObjects(self)
    }
}
