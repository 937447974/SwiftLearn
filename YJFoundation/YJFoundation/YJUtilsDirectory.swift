//
//  YJUtilsDirectory.swift
//  YJFoundation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by admin on 16/3/20.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// app应用目录
public struct YJUtilsDirectory {
    
    // MARK: - path路径
    /// HomeDirectoryPath
    static let homePath = NSHomeDirectory()
    /// DocumentDirectoryPath
    static let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    /// LibraryDirectoryPath
    static let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
    /// CachesDirectoryPath
    static let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    /// TemporaryDirectoryPath
    static let tempPath = NSTemporaryDirectory()
    
    // MARK: - url 路径
    /// HomeDirectoryURL
    static let homeURL = URL(fileURLWithPath: YJUtilsDirectory.homePath)
    /// DocumentDirectoryURL
    static let documentURL = URL(fileURLWithPath: YJUtilsDirectory.homePath)
    /// LibraryDirectoryURL
    static let libraryURL = URL(fileURLWithPath: YJUtilsDirectory.libraryPath)
    /// CachesDirectoryURL
    static let cachesURL = URL(fileURLWithPath: YJUtilsDirectory.cachesPath)
    /// TemporaryDirectoryURL
    static let tempURL = URL(fileURLWithPath: YJUtilsDirectory.tempPath)
    
}
