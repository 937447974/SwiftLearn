//
//  YJDownloadTaskVC.swift
//  NSURLSession
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/3.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

// NSURLSessionDownloadTask 下载
class YJDownloadTaskVC: UIViewController, NSURLSessionDownloadDelegate {

    /// 下载器
    private var downloadTask: NSURLSessionDownloadTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 相关按钮
        // 刷新
        let refreshItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "downloadTaskRefresh")
        // 开始
        let resumeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "downloadTaskResume")
        self.navigationItem.leftBarButtonItems = [refreshItem, resumeItem]
        // 暂停
        let suspendItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "downloadTaskSuspend")
        // 取消
        let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "downloadTaskCancel")
        self.navigationItem.rightBarButtonItems = [cancelItem, suspendItem]
        
        // NSURLSessionDownloadTask
        self.downloadTaskRefresh()
        // self.testQueue() // 队列测试
    }
    

    // MARK: - 队列测试
    func testQueue() {
        let usrString = "http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"
        let url = NSURL(string: usrString)
        let request = NSMutableURLRequest(URL: url!)
        let session = self.backgroundSession()
        // 并发下载10个文件
        for _ in 0..<10 {
            session.downloadTaskWithRequest(request).resume()
        }
    }
    
    // MARK: - action
    // MARK: 刷新
    func downloadTaskRefresh() {
        // 这是一张高清图片
        let usrString = "http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"
        let url = NSURL(string: usrString)
        let request = NSMutableURLRequest(URL: url!)
        let session = self.backgroundSession()
        self.downloadTask = session.downloadTaskWithRequest(request)
    }
    
    // MARK: 开始下载
    func downloadTaskResume() {
        self.downloadTask?.resume()
    }
    
    // MARK: 暂停下载
    func downloadTaskSuspend() {
        self.downloadTask?.suspend()
    }
    
    // MARK: 取消下载
    func downloadTaskCancel() {
        self.downloadTask?.cancel()
    }
    
    // MARK: - 后台下载
    // MARK: 获取后台下载的session
    private func backgroundSession() -> NSURLSession{
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var session: NSURLSession!
        }
        //var static session: NSURLSession!
        dispatch_once(&Static.onceToken, { () -> Void in
            let sessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("com.downloadTask.URLSession")
            sessionConfiguration.timeoutIntervalForRequest = 20// 请求超时时间
            sessionConfiguration.discretionary = true // 系统自动选择最佳网络下载
            sessionConfiguration.HTTPMaximumConnectionsPerHost = 5// 限制每次最多5个连接
            Static.session = NSURLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)//指定配置和代理
        })
        return Static.session
    }
    
    // MARK: - NSURLSessionDelegate
    // MARK: 下载完成
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        // 下载完成的地址
        print(location)
    }
    
    // MARK: 下载中(会多次调用，可以记录下载进度)
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress: Float = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print("\(totalBytesExpectedToWrite)--\(totalBytesWritten)--\(progress)")
    }
    
    // MARK: 重新开始下载
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        let progress: Float = Float(fileOffset) / Float(expectedTotalBytes)
        print("已下载\(progress)")
    }
    
    // MARK: - NSURLSessionTaskDelegate
    // MARK: 任务完成，不管是否下载成功
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print("错误: \(error)")
    }
    
}
