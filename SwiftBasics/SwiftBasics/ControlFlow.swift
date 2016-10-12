//
//  ControlFlow.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/26.
//  Copyright © 2015年 六月. All rights reserved.
//

import Foundation

/// 控制流
class ControlFlow: NSObject, TestProtocol {

    func test() {
    //        self.testFor()
    //        self.testForIn()
    //        self.testWhile()
    //        self.testRepeatWhile()
    //        self.testIf()
    //        self.testSwitch()
    //        self.testControlTransfer() // 控制转移
    //        self.testEarlyExit()
    //        self.testCheckingAPIAvailability()
    }

    // MARK: - 传统for循环
    fileprivate func testFor() {
        for index in 0 ..< 3 {
            print("index is \(index)")
        }
    }

    // MARK: for-in循环
    fileprivate func testForIn() {
        // 直接循环提取内部数据
        // [1,5]
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        // 不需要提取数据，只需要循环次数
        let base = 2
        let power = 3
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        // array遍历
        let array = ["阳君", "937447974"]
        for item in array {
            print("array:\(item)!")
        }
        // Dictionary遍历
        let dict = ["name":"阳君", "qq":"937447974"]
        for (key, value) in dict {
            print("key:\(key);value:\(value)")
        }
    }

    // MARK: - While循环
    fileprivate func testWhile() {
        // 先执行while条件判断，后执行内部代码
        let count = 4
        var index = 0
        while index < count {
            index += 1
            print("while:\(index)")
        }
    }

    // MARK: repeat-while循环
    fileprivate func testRepeatWhile() {
        // 执行内部代码后判断条件
        let count = 4
        var index = 0
        repeat {
            index += 1
            print("RepeatWhile:\(index)")
        } while index < count
    }

    // MARK: - 条件判断
    // MARK: if 判断
    fileprivate func testIf() {
        // 一个条件一个条件的判断，当条件为真时，执行内部程序
        let temp = 90
        if temp <= 32 {
            // 不执行
        } else if temp >= 86 {
            print("执行")
        } else {
            // 不执行
        }
    }

    // MARK: swich判断
    fileprivate func testSwitch() {
        // 基本switch,case不会穿透。
        let someCharacter: Character = "a"
        switch someCharacter {
        case "a":
            print("1")
        case "a", "b", "c":
            print("2") //这里不会输出，case找到后，执行完毕就返回
        default:
            print("未找到")
        }
        self.testSwitchIntervalMatching()
        self.testSwitchTuples()
        self.testSwitchValueBindings()
        self.testSwitchValueBindingsWhere()
    }

    // MARK: switch范围选择
    fileprivate func testSwitchIntervalMatching() {
        // 范围选择
        let approximateCount = 2
        switch approximateCount {
        case 1..<5:
            print("[1, 5)")
        case 5..<10:
            print("[5, 10)")
        default:
            print("未找到")
        }
    }

    // MARK: switch元组选择
    fileprivate func testSwitchTuples() {
        // 元组选择,坐标轴测试
        let random = arc4random()// 随机数
        let somePoint = (Int(random%3), Int(random%3))// 随机数获取点
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
    }

    // MARK: switch值选择
    fileprivate func testSwitchValueBindings() {
        let random = arc4random()// 随机数
        // 值绑定,如果设置未知数，当匹配成功时，执行此代码
        let anotherPoint = (Int(random%3), Int(random%1))
        switch anotherPoint {
        case (let x, 0):
            print("\(x)，x匹配")
        case (0, let y):
            print("\(y)，y匹配")
        case let (x, y):
            print("(\(x), \(y))，其他")
        }
    }

    // MARK: switch值绑定和where
    fileprivate func testSwitchValueBindingsWhere() {
        // 使用where条件二次判断
        let random = arc4random()// 随机数
        let yetAnotherPoint = (Int(random%3), Int(random%3))
        switch yetAnotherPoint {
        case let (x, y) where x < y:
            print("\(x) < \(y)")
        case let (x, y) where x > y:
            print("\(x) > \(y)")
        case let (x, y):
            print("\(x) = \(y)")
        }
    }

    // MARK: - 控制转移语句
    fileprivate func testControlTransfer() {
        self.testContinue()
        self.testBreak()
        self.testFallthrough()
        self.testLabeledStatements()
    }

    // MARK: continue
    fileprivate func testContinue() {
        // 跳过本次循环，继续执行下次循环
        for index in 1...5 {
            if index == 2 {
                continue
            }
            print("continue:\(index)")
        }
    }

    // MARK: break
    fileprivate func testBreak() {
        // 跳过当前for或者switch，继续执行
        for x in 1...5 {
            if x == 2 {
                break
            }
            print("break-x:\(x)")
        }
        print("break-for")
        let z = 0
        switch z {
        case 0:
            break;
        default:
            break;
        }
        print("break-switch")
    }

    // MARK: fallthrough
    fileprivate func testFallthrough() {
        // 击穿：执行当前case内的代码，并执行下一个case内的代码
        let x = Int(arc4random()%1)// 0
        switch x {
        case 0:
            print("0")
            fallthrough
        case  1:
            print("1")
            fallthrough
        default:
            break;
        }
    }

    // MARK: 标签
    fileprivate func testLabeledStatements() {
        // 标签语句，可以直接跳到写标签行的代码
        var b = false
        go : while true {
            print("go")
            switch b {
            case true:
                print("true")
                break go // 跳过go标签的代码
            case false:
                print("false")
                b = true
                continue go // 继续执行go标签的代码
            }
        }
    }

    // MARK: - 提前退出
    fileprivate func testEarlyExit() {
        // guard和if很像，当条件判断为假时，才执行else中的代码
        func greet(_ person: [String: String]) {
            guard let name = person["name"] else {
                print("无name")
                return
            }
            print("name: \(name)!")
        }
        
        greet([:])
        greet(["name": "阳君"])
    }

    // MARK: - 检查API可用性
    fileprivate func testCheckingAPIAvailability() {
        if #available(iOS 9.1, OSX 10.10, *) {
            print("iOS 9.1, OSX 10.10, *")
        } else {
            print("低版本")
        }
    }
    
}
