//
//  ErrorHandling.swift
//  SwiftBasics
//
//  Created by yangjun on 15/11/1.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 错误处理
class ErrorHandling: TestProtocol {

    func test() {
        
        /// 错误枚举,需ErrorType协议
        enum ErrorEnum: Error {
            case `default` // 普通错误
            case other(tag: Int) // 高级错误，可携带数据
        }
        
        class SomeClass {
            
            func canThrowErrors(_ str: String) throws {
                // 当str不为Default时，输出错误
                guard str == "Default" else {
                    throw ErrorEnum.default
                }
                // 当str部位Other时输出错误
                guard str == "Other" else {
                    throw ErrorEnum.other(tag: 5)
                }
            }
            
        }
        
        let sClass = SomeClass()
        // try! sClass.canThrowErrors("Default") // 强制调用,错误时程序闪退。
        do {
            try sClass.canThrowErrors("Default")
            try sClass.canThrowErrors("Other")
        } catch ErrorEnum.default {
            print("默认错误")
        } catch ErrorEnum.other(let tag) where tag == 5 {
            print("错误代码：\(tag)")
        } catch ErrorEnum.other(let tag) {
            print("其他错误：\(tag)")
        } catch {
            // 在捕获中，隐式携带error错误。
            print("未知错误：\(error)")
        }
        
    }
    
}
