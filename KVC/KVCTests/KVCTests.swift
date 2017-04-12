//
//  KVCTests.swift
//  KVCTests
//
//  Created by yangjun on 15/10/10.
//  Copyright © 2015年 六月. All rights reserved.
//

import XCTest
@testable import KVC

/// KVC测试
class KVCTests: XCTestCase {
        
    /// 用户
    var user:User!
    
    // MARK: 开始
    override func setUp() {
        super.setUp()
        self.user = User()
    }
    
    func testExample() {
        // 简单路径
        self.user.setValue("yangj", forKey:"userName") // 传值
        var value = self.user.value(forKey: "userName") as? String // 取值
        print("\(value ?? "")")
        
        // 复合路径
        self.user.setValue("阳", forKeyPath: "userName")
        value = self.user.value(forKeyPath: "userName") as? String
        print("\(value ?? "")")
        
        // 字典
        let dict = ["userName":"阳君"]
        self.user.setValuesForKeys(dict)
        let dictOut = self.user.dictionaryWithValues(forKeys: ["userName"])
        print("\(dictOut)")
    }

}
