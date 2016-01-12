//
//  YJUtils.swift
//  Utils
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// user interface
public struct YJUtilUserInterfaceIdiom {
    
    /// The user interface should be designed for iPhone and iPod touch.
    static let isPhone = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
    /// The user interface should be designed for iPad.
    static let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
    /// The user interface should be designed for Apple TV.
    static let isAppleTv = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.TV
    
}


/// 屏幕尺寸
public struct YJUtilScreenSize {
    
    /// 屏幕宽
    static let screenWidth = UIScreen.mainScreen().bounds.size.width
    /// 屏幕高
    static let screenHeight = UIScreen.mainScreen().bounds.size.height
    /// 屏幕最大长度
    static let screenMaxLength = max(YJUtilScreenSize.screenWidth, YJUtilScreenSize.screenHeight)
    /// 屏幕最小长度
    static let screenMinLength = min(YJUtilScreenSize.screenWidth, YJUtilScreenSize.screenHeight)
    
}


/// 机型
public struct YJUtilDeviceType {
    
    /// IPhone4
    static let isIPhone4 = YJUtilUserInterfaceIdiom.isPhone && YJUtilScreenSize.screenMaxLength == 480.0
    /// IPhone5
    static let isIPhone5 = YJUtilUserInterfaceIdiom.isPhone && YJUtilScreenSize.screenMaxLength == 568.0
    /// IPhone6
    static let isIPhone6 = YJUtilUserInterfaceIdiom.isPhone && YJUtilScreenSize.screenMaxLength == 667.0
    /// IPhone6P
    static let isIPhone6P = YJUtilUserInterfaceIdiom.isPhone && YJUtilScreenSize.screenMaxLength == 736.0
    
}


/// app相关信息
public struct YJUtilAPP {
    
    /// Info.plist
    static let infoDictionary = NSBundle.mainBundle().infoDictionary!
    /// 项目名称
    static let executable = YJUtilAPP.infoDictionary[String(kCFBundleExecutableKey)]
    /// bundle Identifier
    static let identifier = NSBundle.mainBundle().bundleIdentifier!
    /// version版本号
    static let shortVersion = YJUtilAPP.infoDictionary["CFBundleShortVersionString"]
    /// build版本号
    static let version = YJUtilAPP.infoDictionary[String(kCFBundleVersionKey)]
    /// app名称
    static let name = YJUtilAPP.infoDictionary[String(kCFBundleNameKey)]
    /// app定位区域
    static let localizations = YJUtilAPP.infoDictionary[String(kCFBundleLocalizationsKey)]
    
}
