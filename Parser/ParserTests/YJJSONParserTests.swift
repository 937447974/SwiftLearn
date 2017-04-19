//
//  YJJSONParserTests.swift
//  Parser
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/7.
//  Copyright © 2015年 阳君. All rights reserved.
//

import XCTest

/// json解析
class YJJSONParserTests: XCTestCase {
    
    var jsonString : String?
    
    override func setUp() {
        super.setUp()
        var dict = [String: String]()
        dict["name"] = "阳君"
        dict["qq"] = "937447974"
        do {
            if JSONSerialization.isValidJSONObject(dict) { // 能否转换为JSON Data
                // 转换为JSON Data
                let data  = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
                // 转换为json串
                self.jsonString = String(data: data, encoding: String.Encoding.utf8)
                print("json生成:\(self.jsonString ?? "")")
            }
        } catch {
            print("转换出错:\(error)")
        }
    }
    
    override func tearDown() {
        super.tearDown()
        self.jsonString = nil
    }
    
    func testExample() {
        // json转data
        if let data = self.jsonString?.data(using: String.Encoding.utf8) {
            do {
                // data转JSON Object
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                // JSON Object转实际对象
                if let dict = jsonObject as? Dictionary<String, AnyObject> {
                    print("json解析:\(dict)")
                }
            } catch {
                print("解析xml出错:\(error)")
            }
        }
    }
    
}
