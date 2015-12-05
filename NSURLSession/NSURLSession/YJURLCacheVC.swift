//
//  YJURLCacheVC.swift
//  NSURLSession
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/5.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import WebKit

/// 缓存
class YJURLCacheVC: UIViewController {
    
    private var request: NSMutableURLRequest!
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlCache = NSURLCache.sharedURLCache()
        urlCache.memoryCapacity = 10*1024*1024 // 设置缓存大小为10M，单位字节
        self.removeCache()
        
        /* 缓存策略
        NSURLRequestCachePolicy : UInt {
        case UseProtocolCachePolicy // 默认的cache policy，使用Protocol协议定义。
        case ReloadIgnoringLocalCacheData // 忽略缓存直接从原始地址下载
        case ReloadIgnoringLocalAndRemoteCacheData // 未实现
        case ReturnCacheDataElseLoad // 只有在cache中不存在data时才从原始地址下载
        case ReturnCacheDataDontLoad // 只使用cache数据，如果不存在cache，请求失败;用于没有建立网络连接离线模式;
        case ReloadRevalidatingCacheData // 未实现
        }
        */
        let url = NSURL(string: "https://www.baidu.com")!
        self.request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 30)

        self.webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(self.webView)
        self.webView.loadRequest(self.request) // 显示页面
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "reloadWebView")
    }
    
    // MARK: - 清楚缓存
    func removeCache() {
        NSURLCache.sharedURLCache().removeAllCachedResponses() // 清楚所有缓存
    }

    // MARK: - 刷新
    func reloadWebView() {
        // 缓存成功后，开启本地缓存
        if NSURLCache.sharedURLCache().cachedResponseForRequest(self.request) != nil {
            self.request.cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataDontLoad
        } else {
            // 发出请求才会缓存数据
            NSURLSession.sharedSession().dataTaskWithRequest(self.request).resume()
        }
        self.webView.loadRequest(self.request)
    }

}
