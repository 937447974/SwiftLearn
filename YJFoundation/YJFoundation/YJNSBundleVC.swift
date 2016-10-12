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
    
    fileprivate func testGettingAnNSBundle() {
        print(Bundle.main)
        print("")
        for bundle in Bundle.allBundles {
            print(bundle)
        }
        print("")
        for bundle in Bundle.allFrameworks {
            print(bundle)
        }
    }
    
    func testGettingABundledClass() {
        print(Bundle.main.principalClass)
    }
    
    func testFindingResources() {
        let bundle = Bundle.main
        print(bundle.resourceURL) // 资源地址
        // 获取info.plist
        print(Bundle.main.url(forResource: "Info", withExtension: "plist"))
    }
    
    func testGettingTheBundleDirectory() {
        let bundle = Bundle.main
        print(bundle.bundlePath)// 包路径
    }
    
    func testGettingBundleInformation() {
        let bundle = Bundle.main
        print(bundle.bundleIdentifier) // bundle Id
        print(bundle.infoDictionary)// info.plist
        print(bundle.builtInPlugInsURL)// 插件
        print(bundle.privateFrameworksURL)// 私有库
        print(bundle.sharedFrameworksURL)// 共享库
        print(bundle.sharedSupportURL)// 共享路径
    }
    
    func testLoadingABundleCode() {
        let bundle = Bundle.main
        print(bundle.executableArchitectures)// 可执行架构
    }
    
    func testManagingLocalizations() {
        let bundle = Bundle.main
        print(bundle.preferredLocalizations)
        print(bundle.developmentLocalization)
        print(bundle.localizedInfoDictionary)
        print(bundle.localizations)
    }
    
}
