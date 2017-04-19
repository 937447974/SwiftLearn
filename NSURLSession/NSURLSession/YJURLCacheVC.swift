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
    
    /// WKWebView
    fileprivate var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 刷新按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(YJURLCacheVC.reloadWebView))
        // 初始化 WKWebView
        self.webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(self.webView)
    }

    // MARK: - 刷新
    func reloadWebView() {
        let urlCache = URLCache.shared
        var str = "memoryCapacity:\(urlCache.memoryCapacity)"
        str += "; diskCapacity:\(urlCache.diskCapacity)"
        str += "; currentMemoryUsage:\(urlCache.currentMemoryUsage)"
        str += "; currentDiskUsage:\(urlCache.currentDiskUsage)"
        print(str)
        
        // 缓存显示照片
//        let url = NSURL(string: "http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg")!
        let url = URL(string: "http://blog.csdn.net/y550918116j")!
        var request = URLRequest(url: url)
        
        // 缓存成功后，开启本地缓存
        if URLCache.shared.cachedResponse(for: request) != nil {
            /* 缓存策略
            NSURLRequestCachePolicy : UInt {
            case UseProtocolCachePolicy // 默认的缓存策略（取决于协议)
            case ReloadIgnoringLocalCacheData // 忽略缓存直接从原始地址下载
            case ReloadIgnoringLocalAndRemoteCacheData // 未实现
            case ReturnCacheDataElseLoad // 只有在cache中不存在data时,才从原始地址下载
            case ReturnCacheDataDontLoad // 只使用cache数据，如果不存在cache，请求失败;用于没有建立网络连接离线模式;
            case ReloadRevalidatingCacheData // 未实现
            }
            */
            request.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataDontLoad // 提取缓存数据
        } else {
            urlCache.removeAllCachedResponses() // 清楚所有缓存
            urlCache.removeCachedResponse(for: request) // 根据地址清楚缓存
            urlCache.diskCapacity = 10*1024*1024 // 磁盘缓存，10M，单位字节
            urlCache.memoryCapacity = 1*1024*1024 // 内存缓存，1M，单位字节
            // 发出请求才会缓存数据
            URLSession.shared.dataTask(with: request).resume()
        }
        self.webView.load(request)
    }

}
