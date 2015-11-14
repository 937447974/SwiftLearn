//
//  Subscripts.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/30.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 下标
class Subscripts: TestProtocol {

    func test() {
        self.testSubscripts()
    }
    
    func testSubscripts() {
        // 下标关键字subscript
        
        /// array测试
        struct TestArray {
            
            /// 内部数组
            var array = Array<Int>()
            
            // MARK: 下标使用
            subscript(index: Int) -> Int {
                get {
                    assert(index < array.count, "下标越界")
                    return array[index]
                }
                set {
                    while array.count <= index {
                        array.append(0)
                    }
                    array[index] = newValue
                }
            }
        }
        
        var array = TestArray()
        array[3] = 4; // 通过下标设置值
        print("\(array[3])") // 4
        print("\(array[4])") // 程序停止
    }
    
}
