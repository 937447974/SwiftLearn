//
//  YJUploadTaskVC.swift
//  NSURLSession
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/3.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// NSURLSessionUploadTask 上传
class YJUploadTaskVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.uploadTaskMain()
        self.uploadTaskBackground()
    }
    
    // MARK: 前台上传
    func uploadTaskMain() {
        // url
        let urlStr = "https://www.baidu.com"
        let url = NSURL(string: urlStr)
        if url == nil {
            return
        }
        // NSURLRequest配置
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST" //设置请求方式为POST，默认为GET
        // 需要添加相关header
        // request.addValue("text/xml", forHTTPHeaderField: "Content-Type")// 定义类型
        // request.addValue("0", forHTTPHeaderField: "Content-Length") //
        // session
        let session = NSURLSession.sharedSession()
        let completionHandler = {(data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if error == nil {
                print("上传成功")
            } else {
                print(error)
            }
        }
        // NSURLSessionUploadTask
        let uploadTask = session.uploadTaskWithRequest(request, fromData: nil, completionHandler: completionHandler)
        uploadTask.resume()//发出请求
    }
    
    // MARK: 后台上传
    func uploadTaskBackground() {
        // url
        let urlStr = "https://www.baidu.com"
        let url = NSURL(string: urlStr)
        if url == nil {
            return
        }
        // NSURLRequest配置
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST" //设置请求方式为POST，默认为GET
        // 需要添加相关header
        // request.addValue("text/xml", forHTTPHeaderField: "Content-Type")// 定义类型
        // request.addValue("0", forHTTPHeaderField: "Content-Length") //
        // 会话配置
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("com.uploadTask.URLSession")
        configuration.HTTPMaximumConnectionsPerHost = 5// 最多同时上传5个文件
        configuration.discretionary = true // 系统自动选择最佳网络
        configuration.timeoutIntervalForRequest = 20 // 请求超时时间
        // 会话
        let session = NSURLSession(configuration: configuration)
        // NSURLSessionUploadTask
        let dataFile = NSBundle.mainBundle().URLForResource("Info", withExtension: "plist")
        let uploadTask = session.uploadTaskWithRequest(request, fromFile: dataFile!)
        // 发出请求
        uploadTask.resume()
    }
    
}
