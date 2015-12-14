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
public struct UserInterfaceIdiom {
    /// The user interface should be designed for iPhone and iPod touch.
    static let isPhone = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
    /// The user interface should be designed for iPad.
    static let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
    /// The user interface should be designed for Apple TV.
    static let isAppleTv = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.TV
    
}

/// 屏幕尺寸
public struct ScreenSize {
    
    /// 屏幕宽
    static let screenWidth = UIScreen.mainScreen().bounds.size.width
    /// 屏幕高
    static let screenHeight = UIScreen.mainScreen().bounds.size.height
    /// 屏幕最大长度
    static let screenMaxLength = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
    /// 屏幕最小长度
    static let screenMinLength = min(ScreenSize.screenMaxLength, ScreenSize.screenHeight)
    
}

/// 机型
public struct DeviceType {
    
    /// IPhone4
    static let isIPhone4 = UserInterfaceIdiom.isPhone && ScreenSize.screenMaxLength == 480.0
    /// IPhone5
    static let isIPhone5 = UserInterfaceIdiom.isPhone && ScreenSize.screenMaxLength == 568.0
    /// IPhone6
    static let isIPhone6 = UserInterfaceIdiom.isPhone && ScreenSize.screenMaxLength == 667.0
    /// IPhone6P
    static let isIPhone6P = UserInterfaceIdiom.isPhone && ScreenSize.screenMaxLength == 736.0
    
}
