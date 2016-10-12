//
//  Closures.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/27.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 闭包
class Closures: TestProtocol {
    
    func test() {
//        self.testClosures()
//        self.testTrailingClosures()
//        self.testCapturingValues()
//        self.testNonescapingClosures()
//        self.testAutoclosures()
    }
    
    // MARK: 闭包优化
    func testClosures() {
        // 函数做参数，排序
        let names = ["阳君", "937447974", "a", "b", "c"]
        func backwards(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        var reversed = names.sorted(by: backwards)
        
        // 闭包排序
        reversed = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        
        // 可以写为一行
        reversed = names.sorted( by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
        
        // 闭包可以自动判断参数类型和返回属性
        reversed = names.sorted( by: { s1, s2 in return s1 > s2 } )
        
        // 当只有一行时，可省略return写法。
        reversed = names.sorted( by: { s1, s2 in s1 > s2 } )
        
        // 闭包中的参数可使用$去获得，第一个参数为$0，第二个为$1
        reversed = names.sorted( by: { $0 > $1 } )
        
        // 当闭包中只有两个参数，做比较操作时，只需要写入符号
        reversed = names.sorted(by: >)
        
        print("\(reversed)")
    }
    
    // MARK: 尾随闭包
    func testTrailingClosures() {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        // 如果函数需要一个闭包作为参数，且这个参数是最后一个参数.
        // 尾随闭包可以放在函数参数列表外，也就是括号外
        var reversed = names.sorted() { $0 > $1 }
        
        // 如果一个闭包表达式作为一个唯一的参数，你又正在使用尾随闭包，可以省略()
        reversed = names.sorted { $0 > $1 }
        
        print("\(reversed)")
    }
    
    // MARK: 捕获值
    func testCapturingValues() {
        /*
        闭包可以根据环境上下文捕获到定义的常量和变量。闭包可以引用和修改这些捕获到的常量和变量，
        就算在原来的范围内定义为常量或者变量已经不再存在（很牛逼）。
        在Swift中闭包的最简单形式是嵌套函数。
        */
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        
        let incrementByTen = makeIncrementer(forIncrement: 10)
        print("\(incrementByTen())") // prints "10"
        print("\(incrementByTen())") // prints "20"
        print("\(incrementByTen())") // prints "30"
        
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        print("\(incrementBySeven())") //  prints "7"
        print("\(incrementByTen())")   //  prints "40"
        
        
        // 闭包是引用类型
        let alsoIncrementByTen = incrementByTen
        alsoIncrementByTen() //  prints "50"
    }
    
    // MARK: 避免内存泄露
    func testNonescapingClosures() {
        // @noescape,保留环问题，闭包中布应使用self。避免内存泄露
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        // prints "200"
        
        completionHandlers.first?()
        print(instance.x)
        // prints "100"
        
    }
    
    // MARK: 闭包内代码做参数
    func testAutoclosures() {
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func serveCustomer(_ customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serveCustomer( { customersInLine.remove(at: 0) } )
        // prints "Now serving Alex!"
        
        
        // customersInLine is ["Ewa", "Barry", "Daniella"]
        func serveCustomer2(_ customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        // 闭包作为参数
        serveCustomer2(customersInLine.remove(at: 0))
        // prints "Now serving Ewa!"
        
        // customersInLine is ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        //autoclosure和escaping一起用
        func collectCustomerProviders( _ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        // 添加闭包，并且闭包此时为参数
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        // prints "Collected 2 closures."
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // prints "Now serving Barry!"
        // prints "Now serving Daniella!"
        
    }
    
}

var completionHandlers: [() -> Void] = []
func someFunctionWithNoescapeClosure(_ closure: () -> Void) {
    closure()
    // completionHandlers.append(closure) 会报错,closure无法被保存
}

func someFunctionWithEscapingClosure(_ completionHandler: @escaping () -> Void) {
    completionHandler()
    completionHandlers.append(completionHandler)
}

class SomeClass {
    var x = 10
    func doSomething() {
        // 内存溢出
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNoescapeClosure { x = 200 }
    }
}
