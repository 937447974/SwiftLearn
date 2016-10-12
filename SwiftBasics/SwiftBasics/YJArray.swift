//
//  YJArray.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/24.
//  Copyright © 2015年 六月. All rights reserved.
//

import Foundation

class YJArray: NSObject, TestProtocol {
    
    func test() {
        self.testCreating() // 初始化
        self.testReadingAndWriting() // 文件读和写
        self.testAdding()   // 增加元素
        self.testQuerying() // 查询数组
        self.testFindingObjects() // 查找元素位置
        self.testRemoving()       // 删除元素
        self.testReplacing()      // 替换元素
        self.testSorting() // 排序
    }
    
    // MARK: 初始化
    fileprivate func testCreating() {
        // 空数组
        var array = [Int]()
        array = []
        array = Array<Int>()
        
        // 有元素的数值
        array = [Int](repeating: 0, count: 3)
        array = [0, 0, 0]
        print("\(array)")
    }

    // MARK: - 查询相关信息
    fileprivate func testQuerying() {
        var array = ["阳君", "937447974", "swift"]
        print("contains:\(array.contains("阳君"))") // 是否存在这个元素
        print("count:\(array.count)")       // 有多少个元素
        print("capacity:\(array.capacity)") // 有多少个元素
        print("startIndex:\(array.startIndex)") // 首坐标
        print("endIndex:\(array.endIndex)")     // 尾脚标
        print("first:\(array.first)") // 首元素
        print("last:\(array.last)")   // 尾元素
        print("isEmpty:\(array.isEmpty)") // 是否为空
        // 获取指定位置的元素
        var temp = (array as NSArray).object(at: 0)
        temp = array[0]
        print("\(temp)")
        // 获取多个元素
        // oc获取
        let nRange : NSRange = NSMakeRange(0, 3)
        let nIndexSet = IndexSet(integersIn: nRange.toRange() ?? 0..<0)
        let ocArray = (array as NSArray).objects(at: nIndexSet)
        print("\(ocArray)")
        // swift获取
        let range = (0 ..< 3)
        let sArray = array[range]
        print("\(sArray)")
        
        // 遍历
        // 只获取元素
        for item in array {
            print(item)
        }
        // 遍历元素和所处的位置
        for (index, value) in array.enumerated() {
            print("\(index):\(value)")
        }
    }

    // MARK: 查找元素位置
    fileprivate func testFindingObjects() {
        let array = ["阳君", "937447974", "swift"]
        // 查找元素
        var index = array.index(of: "swift")
        // closures查找
        index = array.index { (str:String) -> Bool in
            if str == "swift" {
                return true
            }
            return false
        }
        // 简写
        index = array.index{ str in return str == "swift" }
        index = array.index{ str in str == "swift" }
        index = array.index{ $0 == "swift"}
        print("index:\(index)")
    }

    // MARK: 增加元素
    fileprivate func testAdding() {
        var array = [String]()
        // 增加一个
        array.append("阳君")
        array += ["阳君"]
        // 增加多个
        array.append(contentsOf: ["937447974", "swift"])
        array += ["937447974", "swift"]
        // 插入
        array.insert("937447974", at: 0)
        // 插入多个
        array.insert(contentsOf: ["937447974", "swift"], at: 0)
    }

    // MARK: 删除元素
    fileprivate func testRemoving() {
        var array = ["阳君", "937447974", "swift"]
        array = array + array + array + array
        var temp = array.removeFirst() // 删除首个元素,并返回删除的元素
        array.removeFirst(2) // 删除前两个元素
        temp = array.removeLast() // 删除最后两个元素
        temp = array.remove(at: 0)// 删除指定位置的元素
        array.removeSubrange((array.indices.suffix(from: 0))) // 删除指定范围的元素
        array.removeAll() // 删除所有元素
        print("\(temp)")
    }

    // MARK: 替换元素
    fileprivate func testReplacing() {
        var array = ["阳君", "937447974", "swift", "IOS"]
        array[1] = "YangJ" // 替换指定位置的元素
        // 替换指定范围的元素
        array[1...3] = ["a", "b"]
        let subRange: CountableRange<Int> = (array.indices.suffix(from: 1))
        array.replaceSubrange(subRange, with: ["c","d","e"])
        
    }

    // MARK: 排序
    fileprivate func testSorting() {
        var array = ["阳君", "937447974", "swift", "IOS"]
        array = array.sorted()
        // 自定义排序
        func backwards(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        array = array.sorted(by: backwards)
        // 简写
        array = array.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        array = array.sorted(by: <)
    }

    // MARK: - 文件读和写
    fileprivate func testReadingAndWriting() {
        // Document目录
        let documents:[String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDirPath = documents.first!
        let path = (docDirPath as NSString).appendingPathComponent("test.plist")
        let url = URL(fileURLWithPath: path)
        var array = ["阳君", "937447974", "swift", "IOS"]
        // 写
        (array as NSArray).write(toFile: path, atomically: true)
        (array as NSArray).write(to: url, atomically: true)
        // 读
        array = NSArray(contentsOfFile: path) as! Array
        array = NSArray(contentsOf: url) as! Array
    }
    
}
