//
//  YJString.swift
//  CommonDataType
//
//  Created by yangjun on 15/10/22.
//  Copyright © 2015年 六月. All rights reserved.
//

import Foundation

class YJString: NSObject, TestProtocol {
    
    func test() {
        self.testTypeAliases() // 类型别名
        self.testInitializers() // 初始化
        self.testWorkingWithPaths() // 文件路径操作
        self.testFile()             // 文件读写操作
        self.testGettingLength()        // 得到长度
        self.testGettingNumericValues() // 得到数值
        self.testCombiningStrings()    // 增加字符串
        self.testDividingStrings()     // 分割字符串
        self.testFindingStrings()      // 查找字符串
        self.testReplacingSubstrings() // 替换字符串
        self.testRemovingSubstrings()  // 删除字符串
        self.testComparingStrings()    // 比较字符串
    }
    
    // MARK: 类型别名
    private func testTypeAliases() {
        
        let index = String.Index.self
        print("\(index)")
        
        let utf8index = String.UTF8Index.self
        print("\(utf8index)")
        
        let utf16index = String.UTF16Index.self
        print("\(utf16index)")
        
        let unicodeScalarIndex = String.UnicodeScalarIndex.self
        print("\(unicodeScalarIndex)")
        
        let greeting = "Guten Tag!"
        greeting[greeting.startIndex] // G
        greeting[greeting.endIndex.predecessor()] // !
        greeting[greeting.startIndex.successor()] // u
        greeting[greeting.startIndex.advancedBy(7)] // a
        
    }
    
    // MARK: 初始化
    private func testInitializers() {
        // 空字符串
        var string:String = String()
        string = ""
        
        // char初始化
        let char: Character = "阳"
        string = String(char)
        string = String.init(char)
        string = "\(char)"
        
        // 通过CharacterView
        let charView:String.CharacterView = String.CharacterView("阳君")
        string = String(charView);
        
        // 通过UTF-16编码
        let utf16:String.UTF16View = string.utf16
        string = String(utf16)
        
        // 通过UTF-8编码
        string = String(string.utf8)
        
        // 多个字符串组合生成
        string = String(stringInterpolation: "阳君", "937447974")
        
        // char初始化，连续count次
        string = String(count: 3, repeatedValue: char)
        
        // 通过其他常用数据初始化
        string = String(stringInterpolationSegment: true)
        string = String(stringInterpolationSegment: 24)
        
        
        // 通过NSString初始化,不推荐
        // 通过字符串生成字符串
        string = NSString(string: "阳君") as String
        string = NSString.init(string: "阳君") as String
        
        // 组合生成
        string = NSString(format: "%@", "阳君") as String
        
        print("\(string)")
    }
    
    // MARK: - 文件路径操作
    private func testWorkingWithPaths() {
        var path = "IOS/Swift"
        // 路径分割成数组
        var pathComponents = (path as NSString).pathComponents
        
        // 数组组合成路径
        path = NSString.pathWithComponents(pathComponents)
        
        // Document目录
        let documents:[String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDirPath = documents.first!
        // 寻找文件夹下包含多少个路径
        var complete = docDirPath.completePathIntoString(caseSensitive: true)
        // 寻找文件夹下包含指定扩展名的文件路径
        var outName = ""
        let filterTypes = ["txt", "plist"]
        complete = docDirPath.completePathIntoString(&outName, caseSensitive: true, matchesIntoArray: &pathComponents, filterTypes: filterTypes)
        print("completePathIntoString:\(complete)")
        
        // 添加路径
        path = (docDirPath as NSString).stringByAppendingPathComponent("test")
        // 添加扩展
        path = (path as NSString).stringByAppendingPathExtension("plist")!
        
        print("是否绝对路径:\((path as NSString).absolutePath)")
        print("最后一个路径名:\((path as NSString).lastPathComponent)")
        print("扩展名:\((path as NSString).pathExtension)")
        
        // 去掉扩展名
        var tempPath:Any = (path as NSString).stringByDeletingPathExtension
        // 去掉最后一个路径
        tempPath = (path as NSString).stringByDeletingLastPathComponent
        print("\(tempPath)")
        
        // 转%格式码
        let allowedCharacters:NSCharacterSet = NSCharacterSet.controlCharacterSet()
        tempPath = path.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
        
        // 转可见
        tempPath = path.stringByRemovingPercentEncoding
        
    }
    
    // MARK: 文件读写操作
    private func testFile() {
        
        var string = "阳君；937447974"
        
        // Document目录
        let documents:[String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDirPath = documents.first!
        let filePath = (docDirPath as NSString).stringByAppendingPathComponent("test.plist")
        let fileUrl = NSURL(fileURLWithPath: filePath)
        
        do {
            // 写入
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
            try string.writeToURL(fileUrl, atomically: true, encoding: NSUTF8StringEncoding)
            
            // 读取
            // 自动解析
            try string = String(contentsOfFile: filePath)
            // 指定编码解析
            try string = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
            // 使用默认的编码解析，如果不能解析，采取默认解析并返回解析编码
            var encoding:NSStringEncoding = NSUTF16LittleEndianStringEncoding
            try string = String(contentsOfFile: filePath, usedEncoding: &encoding)
            
            // URl 读取
            try string = String(contentsOfURL: fileUrl)
            try string = String(contentsOfURL: fileUrl, encoding: NSUTF8StringEncoding)
            try string = String(contentsOfURL: fileUrl, usedEncoding: &encoding)
        } catch {
            print("错误:\(error)")
        }
        
    }
    
    // MARK: - 获取字符串的Swift属性
    private func testGettingProperties() {
        let string = String(stringInterpolation: "阳君", "y;j", "937447974")
        
        // String.CharacterView
        print("String.CharacterView:\(string.characters)")
        
        // String.UnicodeScalarView
        print("String.UnicodeScalarView:\(string.unicodeScalars)")
        
        // String.UTF16View
        print("String.UTF16View:\(string.utf16)")
        
        // String.UTF8View
        print("String.UTF8View:\(string.utf8)")
        
        // hash值
        print("hashValue:\(string.hashValue)")
        
        // 是否为空
        print("isEmpty:\(string.isEmpty)")
    }
    
    // MARK: 获取字符串长度
    private func testGettingLength() {
        let string = "阳君；937447974"
        // 起始位置
        var index =  string.startIndex
        // 结束位置
        index = string.endIndex
        print("\(index)")
        // NSString方式获取长度
        var length = (string as NSString).length
        // swift方式获取
        length = string.startIndex.distanceTo(string.endIndex)
        print("\(length)")
        // 通过编码获取长度
        length = string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        // 返回存储时需要指定的长度
        length = string.maximumLengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
    
    // MARK: - 大小写变化
    private func testChangingCase() {
        let str = "阳君;y937447974J"
        // 大写和小写
        print("uppercaseString:\(str.uppercaseString);lowercaseString:\(str.lowercaseString)")
    }
    
    // MARK: 得到数值
    private func testGettingNumericValues() {
        let string = "24"
        let nStr = string as NSString // 借用NSString输出
        print("doubleValue:\(nStr.doubleValue)")
        print("floatValue:\(nStr.floatValue)")
        print("intValue:\(nStr.intValue)")
        print("integerValue:\(nStr.integerValue)")
        print("longLongValue:\(nStr.longLongValue)")
        print("boolValue:\(nStr.boolValue)")
    }
    
    // MARK: - 增加字符串
    private func testCombiningStrings() {
        var str = "阳君;937447974"
        
        // 添加字符串
        str.appendContentsOf(";Swift")
        str += ";11"
        str.write("222")
        
        // string后增加字符串并生成一个新的字符串
        str = str.stringByAppendingString(str)
        
        // string后增加组合字符串并生成一个新的字符串
        str = str.stringByAppendingFormat(";%@", "OC")
        
        // string后增加循环字符串，stringByPaddingToLength：完毕后截取的长度；startingAtIndex：从增加的字符串第几位开始循环增加。
        str = str.stringByPaddingToLength(30, withString:";Swift", startingAtIndex:3)
        
        // 指定位置插入Character
        str.insert("5", atIndex: str.endIndex.advancedBy(-1))
        
        // 指定位置插入字符串
        str.insertContentsOf("78".characters, at: str.startIndex.advancedBy(9))
    }
    
    // MARK: 分割字符串
    private func testDividingStrings() {
        let str = "阳君;937447974"
        
        // 根据指定的字符串分割成数组
        var array = str.componentsSeparatedByString(";")
        
        // 通过系统自带的分割方式分割字符串
        array = str.componentsSeparatedByCharactersInSet(NSCharacterSet.lowercaseLetterCharacterSet())
        print("array\(array)")
        
        // 指定位置后的字符串
        var tempStr = str.substringFromIndex(str.startIndex.advancedBy(3))
        
        // 指定位置前的字符串
        tempStr = str.substringToIndex(str.startIndex.advancedBy(3))
        
        // 指定范围的字符串
        let range = str.endIndex.advancedBy(-6)..<str.endIndex
        tempStr = str.substringWithRange(range)
        print("tempStr:\(tempStr)")
        
    }
    
    // MARK: 查找字符串
    private func testFindingStrings() {
        let str = "阳君;\n937447974";
        let searchRange = str.startIndex ..< str.startIndex.advancedBy(10)
        
        // 根据NSCharacterSet查找
        let cSet = NSCharacterSet.uppercaseLetterCharacterSet()
        var range = str.rangeOfCharacterFromSet(cSet)
        
        // 根据字符串查找
        range = str.rangeOfString("93")
        range = str.rangeOfString("93", options: NSStringCompareOptions.CaseInsensitiveSearch, range: searchRange, locale: nil)
        print("\(range)")
        
        // block 行查找
        str.enumerateLines { (line, stop) -> () in
            print("\(line)")
            if "93" == line {
                stop = true
            }
        }
        
        // block查找，可设置查找方式，并得到找到的位置
        str.enumerateSubstringsInRange(searchRange, options: NSStringEnumerationOptions.ByComposedCharacterSequences) { (substring, substringRange, enclosingRange, stop) -> () in
            print("\(substring)")
            if "9" == substring {
                print("\(substringRange)")
                stop = true
            }
        }
        
    }
    
    // MARK: 替换字符串
    private func testReplacingSubstrings() {
        
        var string = "阳君;937447974"
        let replacingRange = string.startIndex ... string.startIndex.advancedBy(3)
        
        // 全局替换
        string = string.stringByReplacingOccurrencesOfString(";", withString: "+")
        // 设置替换的模式，并设置范围
        string = string.stringByReplacingOccurrencesOfString("+", withString: ";", options: NSStringCompareOptions.CaseInsensitiveSearch, range: replacingRange)
        
        //将指定范围的字符串替换为指定的字符串
        string.replaceRange(replacingRange, with: "12345")
        string = string.stringByReplacingCharactersInRange(replacingRange, withString: "12345")
        
    }
    
    // MARK: 删除字符串
    private func testRemovingSubstrings() {
        var string = "阳君;937447974"
        // 删除指定位置的字符串
        string.removeAtIndex(string.startIndex.advancedBy(1))
        
        // 根据范围删除字符串
        let range = string.endIndex.advancedBy(-6)..<string.endIndex
        string.removeRange(range)
        
        // 删除所有
        string.removeAll()
        string.removeAll(keepCapacity: true)
    }
    
    // MARK: 比较字符串
    private func testComparingStrings() {
        
        var string = "阳君;937447974"
        let compareStr = "阳君;837447974"
        let searchRange = string.startIndex ..< string.endIndex
        
        // 前缀
        var isHas = string.hasPrefix("阳君")
        print("hasPrefix:\(isHas)")
        
        // 后缀
        isHas = string.hasSuffix("Swift")
        print("hasSuffix:\(isHas)")
        
        // 全比较是否相同
        isHas = string == compareStr
        
        // 比较大小
        var result = string.compare(compareStr)
        // 添加比较范围
        result = string.compare(compareStr, options: NSStringCompareOptions.CaseInsensitiveSearch, range: searchRange, locale: nil)
        print("result:\(result)")
        
        // 返回两个字符串相同的前缀
        string = string.commonPrefixWithString(compareStr, options: NSStringCompareOptions.CaseInsensitiveSearch)
        
    }
    
}
