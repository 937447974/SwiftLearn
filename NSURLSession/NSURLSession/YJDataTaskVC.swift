//
//  YJDataTaskVC.swift
//  NSURLSession
//
//  Created by yangjun on 15/12/3.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// NSURLSessionDataTask交互
class YJDataTaskVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendRequestPost()
        self.sendRequestGet()
    }
    
    // MARK: - 异步
    // MARK: Get请求
    func sendRequestGet() {
        // 获取当前文件内容
        let urlStr = "https://raw.githubusercontent.com/937447974/Swift/master/NSURLSession/NSURLSession/YJDataTaskVC.swift"
        if let url = NSURL(string: urlStr) {
            // 包装请求地址和信息
            let request = NSURLRequest(URL: url)
            // 1. session处理，这里使用全局共享session
            let session = NSURLSession.sharedSession()
            // 2. 获取NSURLSessionDataTask
            let dataTask = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                // 有回调数据
                if data != nil {
                    self.jsonObjectWithData(data!)
                } else {
                    print("发送请求出错:\(error?.localizedDescription)")
                }
            }
            dataTask.resume() // 3.发出http请求
        }
    }
    
    // MARK: - Post请求
    func sendRequestPost() {
        let urlStr = "https://www.baidu.com"
        if let url = NSURL(string: urlStr) {
            // 包装请求地址和信息
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST" //设置请求方式为POST，默认为GET
            request.addValue("text/xml", forHTTPHeaderField: "Content-Type")// 定义类型
            // 填充数据
            let dict = ["name": "阳君", "qq": "937447974"]
            do {
                try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            } catch {
                print("json处理出错:\(error)")
            }
            // 1. session处理，这里使用全局共享session
            let session = NSURLSession.sharedSession()
            // 2. 获取NSURLSessionDataTask
            let dataTask = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                // 有回调数据
                if data != nil {
                    self.jsonObjectWithData(data!)
                } else {
                    print("发送请求出错:\(error?.localizedDescription)")
                }
            }
            dataTask.resume() // 3.发出http请求
        }
    }
    
    // MARK: - data数据转换
    func jsonObjectWithData(data: NSData) -> [String: AnyObject]? {
        var dict: [String: AnyObject]? = nil
        do {
            // data -> AnyObject
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            dict = jsonObject as? [String: AnyObject]
            print("获取服务器的数据:\(dict)")
        } catch {
            print("服务器回调数据，转换出错:\(error)")
            print("原始数据：\(NSString(data: data, encoding: NSUTF8StringEncoding)))")
        }
        return dict
    }
    
    
    
    
    
}
