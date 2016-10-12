//
//  ViewController.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/23.
//  Copyright © 2015年 六月. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#file)
        print(#function)
        // Do any additional setup after loading the view, typically from a nib.
        var obj : TestProtocol!
    #if false
        obj = YJString()
        obj.test()
        obj = YJArray()
        obj.test()
        obj = YJSet()
        obj.test()
        obj = YJDictionary()
        obj.test()
        // 控制流
        obj = ControlFlow()
        obj.test()
        // 函数
        obj = Functions()
        obj.test()
        // 闭包
        obj = Closures()
        obj.test()
        // 枚举
        obj = Enumerations()
        obj.test()
        // 类和结构体
        obj = ClassesStructures()
        obj.test()
        // 属性
        obj = Properties()
        obj.test()
        // 方法
        obj = Methods()
        obj.test()
        // 下标
        obj = Subscripts()
        obj.test()
        // 继承
        obj = Inheritance()
        obj.test()
        // 初始化
        obj = Initialization()
        obj.test()
        // 销毁
        obj = Deinitialization()
        obj.test()
        // 可选链
        obj = OptionalChaining()
        obj.test()
        // 抛错
        obj = ErrorHandling()
        obj.test()
        // 类型选择
        obj = TypeCasting()
        obj.test()
        // 扩展
        obj = Extensions()
        obj.test()
        // 协议
        obj = YJProtocol()
        obj.test()
        // 访问控制
        obj = AccessControl()
        // 高级操作符
        var shiftBits = 1   // 00000100 in binary
        shiftBits = shiftBits << 1             // 00001000
        shiftBits = shiftBits << 2             // 00010000
        shiftBits << 5             // 10000000
        shiftBits << 6             // 00000000
        shiftBits >> 2             // 00000001
        print(Int8.max)
        print(Int.max)
        print(UInt8.max)
    #endif
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

