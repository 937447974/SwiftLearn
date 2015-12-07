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
        var dict:Dictionary<String, String> = Dictionary();
        dict["name"] = "阳君"
        dict["qq"] = "937447974"
        do {
            let data  = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            self.jsonString = String(data: data, encoding: NSUTF8StringEncoding)
            print("json生成:\(self.jsonString)")
        } catch {
            print("转换出错")
        }
        
    }
    
    override func tearDown() {
        super.tearDown()
        self.jsonString = nil
    }
    
    func testExample() {
        if let data = self.jsonString?.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let jsonObject:AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                let dict = jsonObject as? Dictionary<String, AnyObject>
                print("json解析:\(dict)")
            } catch {
                print("解析xml出错")
            }
        }
    }
    
}
