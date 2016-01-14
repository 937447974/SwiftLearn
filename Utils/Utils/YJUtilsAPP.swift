//
//  YJUtilsAPP.swift
//  Utils
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/14.
//  Copyright © 2016年 阳君. All rights reserved.
//

import Foundation

/// app相关信息
public struct YJUtilsAPP {
    
    /// Info.plist
    static let infoDictionary = NSBundle.mainBundle().infoDictionary!
    /// 项目名称
    static let executable = YJUtilsAPP.infoDictionary[String(kCFBundleExecutableKey)]
    /// bundle Identifier
    static let identifier = NSBundle.mainBundle().bundleIdentifier!
    /// version版本号
    static let shortVersion = YJUtilsAPP.infoDictionary["CFBundleShortVersionString"]
    /// build版本号
    static let version = YJUtilsAPP.infoDictionary[String(kCFBundleVersionKey)]
    /// app名称
    static let name = YJUtilsAPP.infoDictionary[String(kCFBundleNameKey)]
    /// app定位区域
    static let localizations = YJUtilsAPP.infoDictionary[String(kCFBundleLocalizationsKey)]
    
}