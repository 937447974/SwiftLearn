//
//  YJUtilsScreenSize.swift
//  Utils
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/14.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// 屏幕尺寸
public struct YJUtilsScreenSize {
    
    /// 屏幕宽
    static let screenWidth = UIScreen.main.bounds.size.width
    /// 屏幕高
    static let screenHeight = UIScreen.main.bounds.size.height
    /// 屏幕最大长度
    static let screenMaxLength = max(YJUtilsScreenSize.screenWidth, YJUtilsScreenSize.screenHeight)
    /// 屏幕最小长度
    static let screenMinLength = min(YJUtilsScreenSize.screenWidth, YJUtilsScreenSize.screenHeight)
    
}
