//
//  YJNSBundleVC.swift
//  YJFoundation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSBundle
class YJNSBundleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.testGettingAnNSBundle()
//        self.testGettingABundledClass()
//        self.testFindingResources()
//        self.testGettingTheBundleDirectory()
//        self.testGettingBundleInformation()
//        self.testLoadingABundleCode()
//        self.testManagingLocalizations()
    }
    
    private func testGettingAnNSBundle() {
        print(NSBundle.mainBundle())
        print("")
        for bundle in NSBundle.allBundles() {
            print(bundle)
        }
        print("")
        for bundle in NSBundle.allFrameworks() {
            print(bundle)
        }
    }
    
    func testGettingABundledClass() {
        print(NSBundle.mainBundle().principalClass)
    }
    
    func testFindingResources() {
        let bundle = NSBundle.mainBundle()
        print(bundle.resourceURL) // 资源地址
        // 获取info.plist
        print(NSBundle.mainBundle().URLForResource("Info", withExtension: "plist"))
    }
    
    func testGettingTheBundleDirectory() {
        let bundle = NSBundle.mainBundle()
        print(bundle.bundlePath)// 包路径
    }
    
    func testGettingBundleInformation() {
        let bundle = NSBundle.mainBundle()
        print(bundle.bundleIdentifier) // bundle Id
        print(bundle.infoDictionary)// info.plist
        print(bundle.builtInPlugInsURL)// 插件
        print(bundle.privateFrameworksURL)// 私有库
        print(bundle.sharedFrameworksURL)// 共享库
        print(bundle.sharedSupportURL)// 共享路径
    }
    
    func testLoadingABundleCode() {
        let bundle = NSBundle.mainBundle()
        print(bundle.executableArchitectures)// 可执行架构
    }
    
    func testManagingLocalizations() {
        let bundle = NSBundle.mainBundle()
        print(bundle.preferredLocalizations)
        print(bundle.developmentLocalization)
        print(bundle.localizedInfoDictionary)
        print(bundle.localizations)
    }
    
}
