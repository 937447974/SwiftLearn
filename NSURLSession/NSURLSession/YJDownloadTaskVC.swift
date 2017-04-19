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
class YJDownloadTaskVC: UIViewController, URLSessionDownloadDelegate {
    
    /// 下载器
    fileprivate var downloadTask: URLSessionDownloadTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 相关按钮
        // 刷新
        let refreshItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(YJDownloadTaskVC.downloadTaskRefresh))
        // 开始
        let resumeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.play, target: self, action: #selector(YJDownloadTaskVC.downloadTaskResume))
        self.navigationItem.leftBarButtonItems = [refreshItem, resumeItem]
        // 暂停
        let suspendItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target: self, action: #selector(YJDownloadTaskVC.downloadTaskSuspend))
        // 取消
        let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(YJDownloadTaskVC.downloadTaskCancel))
        self.navigationItem.rightBarButtonItems = [cancelItem, suspendItem]
        
        // NSURLSessionDownloadTask
        self.downloadTaskRefresh()
        // self.testQueue() // 队列测试
    }
    
    
    // MARK: - 队列测试
    func testQueue() {
        let usrString = "http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"
        if let url = URL(string: usrString) {
            let session = self.backgroundSession()
            // 并发下载10个文件
            for _ in 0..<10 {
                session.downloadTask(with: url).resume()
            }
        }
    }
    
    // MARK: - action
    // MARK: 刷新
    func downloadTaskRefresh() {
        // 这是一张高清图片
        let usrString = "http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"
        if let url = URL(string: usrString) {
            let session = self.backgroundSession()
            self.downloadTask = session.downloadTask(with: url)
        }
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
    fileprivate func backgroundSession() -> Foundation.URLSession{
        let sessionConfiguration = URLSessionConfiguration.background(withIdentifier: "com.downloadTask.URLSession")
        sessionConfiguration.timeoutIntervalForRequest = 20// 请求超时时间
        sessionConfiguration.isDiscretionary = true // 系统自动选择最佳网络下载
        sessionConfiguration.httpMaximumConnectionsPerHost = 5// 限制每次最多5个连接
        return URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)//指定配置和代理
    }
    
    // MARK: - NSURLSessionDelegate
    // MARK: 下载完成
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // 下载完成的地址
        print(location)
    }
    
    // MARK: 下载中(会多次调用，可以记录下载进度)
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress: Float = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print("\(totalBytesExpectedToWrite)--\(totalBytesWritten)--\(progress)")
    }
    
    // MARK: 重新开始下载
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        let progress: Float = Float(fileOffset) / Float(expectedTotalBytes)
        print("已下载\(progress)")
    }
    
    // MARK: - NSURLSessionTaskDelegate
    // MARK: 任务完成，不管是否下载成功
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("错误: \(error?.localizedDescription ?? "")")
    }
    
}
