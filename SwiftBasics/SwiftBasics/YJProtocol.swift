//
//  YJProtocol.swift
//  SwiftBasics
//
//  Created by yangjun on 15/11/1.
//  Copyright © 2015年 六月. All rights reserved.
//

import Foundation

@objc protocol YJSomeProtocol:class {
    
    // class代表只用类才能实现这个协议
    func test()
    
    // @objc:OC特性，代表可以使用optional特性。optional可选的方法
    @objc optional func testOptional()
    
}

protocol YJAnotherProtocol: YJSomeProtocol {
    
    // 协议可继承

}

/// 协议扩展
extension YJSomeProtocol {
    
    func testExtension() {
        print(#function)
    }

}

class YJSomeClass:NSObject, YJSomeProtocol {

    func test() {
        print(#function)
    }
    
}

/// 协议
class YJProtocol: TestProtocol {

    func test() {
        let yjs = YJSomeClass()
        yjs.test()
        yjs.testExtension()
    }
    
}
