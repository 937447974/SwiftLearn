//
//  AccessControl.swift
//  SwiftBasics
//
//  Created by yangjun on 15/11/2.
//  Copyright © 2015年 六月. All rights reserved.
//

open class SomePublicClass {          // 明确 public class
    open var somePublicProperty = 0    // 明确 public class 成员
    var someInternalProperty = 0         // 默认 internal class 成员
    fileprivate func somePrivateMethod() {}  // 明确 private class 成员
}

class SomeInternalClass {               // 默认 internal class
    var someInternalProperty = 0         // 默认 internal class 成员
    fileprivate func somePrivateMethod() {}  // 明确 private class 成员
}

private class SomePrivateClass {        // 明确 private class
    var somePrivateProperty = 0          // 默认 private class 成员
    func somePrivateMethod() {}          // 默认 private class 成员
}

// 访问控制
open class AccessControl: TestProtocol {

    func test() {
        
        
        
    }
    
}
