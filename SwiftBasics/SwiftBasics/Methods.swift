//
//  Methods.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/29.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 方法
class Methods: TestProtocol {
    
    func test() {
//        self.testInstanceMethods() // 实例方法
//        self.testTypeMethods()     // 类型方法
    }
    
    // MARK: 实例方法（-）
    func testInstanceMethods() {
        self.testLocalAndExternalParameterNames()
        self.testSelfProperty()
        self.testModifyingValueTypesFromWithinInstanceMethods()
        self.testAssigningToSelfWithinMutatingMethod()
    }
    
    // MARK: 内部和外部属性
    func testLocalAndExternalParameterNames() {
        class Counter {
            var count: Int = 0
            func incrementBy(_ amount: Int, numberOfTimes: Int) {
                count += amount * numberOfTimes
            }
        }
        let counter = Counter()
        counter.incrementBy(5, numberOfTimes: 3)
        print("\(counter.count)") // 15
    }
    
    // MARK: self属性
    func testSelfProperty() {
        // self属性
        struct Point {
            var x = 0.0, y = 0.0
            func isToTheRightOfX(_ x: Double) -> Bool {
                // 这里有内部和外部属性
                return self.x > x
            }
        }
        let somePoint = Point(x: 4.0, y: 5.0)
        print("\(somePoint.isToTheRightOfX(1.0))") // true
    }
    
    // MARK: 在实例方法中修改值类型
    func testModifyingValueTypesFromWithinInstanceMethods() {
        // 因为结构体是值对象，其内部方法无法修改外部值，为了让结构体支持修改结构体内的属性。
        // 方法体前加mutating,让结构体的实例方法可以修改结构体中的值
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveByX(_ deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveByX(2.0, y: 3.0)
        print("(\(somePoint.x), \(somePoint.y))") // (3.0, 4.0)
        let fixedPoint = Point(x: 3.0, y: 3.0)
        // 结构体是值对象，使用let常量后，无法修改内部值
//        fixedPoint.moveByX(2.0, y: 3.0) // 抛错
    }
    
    // MARK: 自我变异
    func testAssigningToSelfWithinMutatingMethod() {
        // mutating还可以修改当前结构体和当前枚举
        // 结构体测试
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveByX(_ deltaX: Double, y deltaY: Double) {
                self = Point(x: x + deltaX, y: y + deltaY)
            }
        }
        
        // 枚举测试
        enum TriStateSwitch {
            case off, low, high
            mutating func next() {
                switch self {
                case .off:
                    self = .low
                case .low:
                    self = .high
                case .high:
                    self = .off
                }
            }
        }
        var ovenLight = TriStateSwitch.low
        print("\(ovenLight.next())") // High
        print("\(ovenLight.next())") // Off
    }
    
    
    // MARK: - 类型方法（+）
    func testTypeMethods() {
        // 类
        class SomeClass {
            class func someTypeMethod() {
                // type method implementation goes here
            }
        }
        SomeClass.someTypeMethod()
        
        // 结构体
        struct LevelTracker {
            // static修改属性，方法体要修改static属性，方法前要使用static
            static var highestUnlockedLevel = 1
            static func levelIsUnlocked(_ level: Int) -> Bool {
                return level <= highestUnlockedLevel
            }
        }
        print("\(LevelTracker.levelIsUnlocked(2))") // false
    }
    
}
