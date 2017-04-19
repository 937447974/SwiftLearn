//
//  YJDataTaskVC.swift
//  NSURLSession
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/3.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// NSURLSessionDataTask交互
class YJDataTaskVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 异步
//        self.sendRequestGet()
//        self.sendRequestPost()
        // 同步
//        self.sendSynchronousRequestPOST()
    }
    
    // MARK: - Get请求
    func sendRequestGet() {
        // 获取当前文件内容
        let urlStr = "https://raw.githubusercontent.com/937447974/Swift/master/NSURLSession/NSURLSession/YJDataTaskVC.swift"
        if let url = URL(string: urlStr) {
            // 1. session处理，这里使用全局共享session
            let session = URLSession.shared
            // 2. 获取NSURLSessionDataTask
            let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                // 有回调数据
                guard data != nil else {
                    print("发送请求出错:\(error?.localizedDescription ?? "")")
                    return
                }
               _ = self.jsonObjectWithData(data!)
            }
            dataTask.resume() // 3.发出http请求
        }
    }
    
    // MARK: - Post请求
    func sendRequestPost() {
        let urlStr = "https://www.baidu.com"
        if let url = URL(string: urlStr) {
            // 包装请求地址和信息
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //设置请求方式为POST，默认为GET
            request.addValue("text/xml", forHTTPHeaderField: "Content-Type")// 定义类型
            // 填充数据
            let dict = ["name": "阳君", "qq": "937447974"]
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
                print("发送数据:\(NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue) ?? "")")
            } catch {
                print("json处理出错:\(error)")
            }
            // 1. session处理，这里使用全局共享session
            let session = URLSession.shared
            // 2. 获取NSURLSessionDataTask
            let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                // 有回调数据
                if data != nil {
                    _ = self.jsonObjectWithData(data!)
                } else {
                    print("发送请求出错:\(error!.localizedDescription)")
                }
            }
            dataTask.resume() // 3.发出http请求
        }
    }
    
    // MARK: - data数据转换
    func jsonObjectWithData(_ data: Data) -> [String: AnyObject]? {
        var dict: [String: AnyObject]? = nil
        do {
            // data -> AnyObject
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            dict = jsonObject as? [String: AnyObject]
            print("获取服务器的数据:\(dict ?? [:])")
        } catch {
            print("服务器回调数据，转换出错:\(error)")
            print("原始数据：\(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? ""))")
        }
        return dict
    }
    
}
