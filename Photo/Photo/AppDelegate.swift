//
//  AppDelegate.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/8.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        print(__FUNCTION__)
        switch PHPhotoLibrary.authorizationStatus() {
        case PHAuthorizationStatus.NotDetermined: // 用户暂未权限认证
            print("PHAuthorizationStatus.NotDetermined")
            // 权限认证
            PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) -> Void in
                print(status)
            }
        case PHAuthorizationStatus.Restricted: // APP禁止使用相册权限认证
            print("PHAuthorizationStatus.Restricted")
        case PHAuthorizationStatus.Denied: // 用户拒绝使用相册
            print("PHAuthorizationStatus.Denied")
            print("请进入 设置 -> 隐私 -> 相册 开启权限")
            // 设置-隐私-相册
        case PHAuthorizationStatus.Authorized: // 用户允许使用相册
            print("PHAuthorizationStatus.Authorized")
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print(__FUNCTION__)
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print(__FUNCTION__)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print(__FUNCTION__)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print(__FUNCTION__)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print(__FUNCTION__)
    }


}

