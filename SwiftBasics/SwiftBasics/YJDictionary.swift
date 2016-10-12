//
//  YJDictionary.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/26.
//  Copyright © 2015年 六月. All rights reserved.
//

import Foundation

class YJDictionary: NSObject, TestProtocol {
    
    func test() {
        self.testInit() // 初始化
        self.testProperties() // 相关属性
        self.testFindingObjects() // 查找元素
        self.testAdd()            // 增加元素
        self.testRemove()         // 删除元素
        self.testReplace()        // 修改元素
        self.testSort() // 排序
        self.testReadingAndWriting() // 文件读写
    }
    
    // MARK: 初始化
    fileprivate func testInit() {
        // 空字典
        var dict = [String:String]()
        dict = [:]
        dict = Dictionary()
        dict = Dictionary<String, String>()
        // 有元素的字典
        dict = ["name":"阳君", "qq":"937447974"]
        dict = Dictionary(dictionaryLiteral: ("name","阳君"), ("qq","937447974"))
        print("\(dict)")
    }
    
    // MARK: 相关属性
    fileprivate func testProperties() {
        let dict = ["name":"阳君", "qq":"937447974"]
        print("count:\(dict.count)") // 有多个对元素
        print("isEmpty:\(dict.isEmpty)") // 是否为空
        // 获取所有key
        let keys = [String](dict.keys)
        print("keys:\(keys)")
        // 获取所有value
        let values = [String](dict.values)
        print("values:\(values)")
        print("startIndex:\(dict.startIndex)") // 首脚标
        print("endIndex:\(dict.endIndex)")     // 尾脚标
    }
    
    // MARK: 查找元素
    fileprivate func testFindingObjects() {
        let dict = ["name":"阳君", "qq":"937447974"]
        if let dictIndex = dict.index(forKey: "name") { // 获取位置
            let item = dict[dictIndex] // 根据位置获取键值对
            print("key:\(item.0);value:\(item.1)")
        }
        let value = dict["name"] // 根据key提取Value
        print("value:\(value)")
        // 遍历输出
        for (key, value) in dict {
            print("\(key): \(value)")
        }
        // 所有key输出
        for key in dict.keys {
            print("key:\(key)")
        }
        // 所有value输出
        for value in dict.values {
            print("value: \(value)")
        }
    }
    
    // MARK: 增加元素
    fileprivate func testAdd() {
        var dict = ["name":"阳君", "qq":"937447974"]
        // 如果没有则添加，有则修改
        dict["language"] = "swift"
    }
    
    // MARK: 删除元素
    fileprivate func testRemove() {
        var dict = ["name":"阳君", "qq":"937447974"]
        let oldValue = dict.removeValue(forKey: "name")// 根据key删除,并返回删除的value
        print("\(oldValue)")
        // 先找到位置，然后根据位置删除
        if let dictIndex = dict.index(forKey: "qq") {
            let oldItem = dict.remove(at: dictIndex)// 返回删除的元素对
            print("key:\(oldItem.0);value:\(oldItem.1)")
        }
        dict.removeAll() // 删除所有元素
    }
    
    // MARK: 修改元素
    fileprivate func testReplace() {
        var dict = ["name":"阳君", "qq":"937447974"]
        // 如果没有则添加，有则修改
        dict["name"] = "YangJun" // 修改
        let oldValue = dict.updateValue("YangJun", forKey: "name") // 修改，并返回原来的value
        print("\(oldValue)")
    }
    
    // MARK: 排序
    fileprivate func testSort() {
        let dict = ["name":"阳君", "qq":"937447974", "a":"1", "b":"1"]
        // 排序主要只排序key或者value,然后借用Array的排序
        // 排序key
        var array = dict.keys.sorted(by: { str1,str2 in str1 < str2 })
         array = dict.keys.sorted(by: <)
        // 排序value
        array = dict.values.sorted(by: {$0 > $1})
        print("\(array)")
    }
    
    // MARK: - 文件读和写
    fileprivate func testReadingAndWriting() {
        // Document目录
        let documents:[String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDirPath = documents.first!
        let path = (docDirPath as NSString).appendingPathComponent("test.plist")
        let url = URL(fileURLWithPath: path)
        var dict = ["name":"阳君", "qq":"937447974"]
        // 写
        (dict as NSDictionary).write(toFile: path, atomically: true)
        (dict as NSDictionary).write(to: url, atomically: true)
        // 读
        dict = NSDictionary(contentsOfFile: path) as! Dictionary
        dict = NSDictionary(contentsOf: url) as! Dictionary
    }
    
}
