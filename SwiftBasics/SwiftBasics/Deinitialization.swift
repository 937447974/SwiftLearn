//
//  Deinitialization.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/31.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 销毁
class Deinitialization: TestProtocol {
    
    func test() {
        
        class SomeClass {
            
            // MARK: 类销毁时，通知此方法
            deinit {
                print("销毁")
            }
            
        }
        
        var sClass:SomeClass? = SomeClass()
        sClass = nil // print "销毁"
        
    }

}
