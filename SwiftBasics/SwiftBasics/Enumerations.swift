//
//  Enumerations.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/28.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 空枚举
enum SomeEnumeration {
    // enumeration definition goes here
}

// 枚举基本类型
enum CompassPoint {
    case North
    case South
    case East
    case West
}

// 简写
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

/// 枚举
class Enumerations: TestProtocol {
    
    func test() {
//        self.testEnumerationSyntax()     // 枚举语法
//        self.testMatchingEnumeration()   // 枚举匹配
//        self.testAssociatedValues()      // 关联值
//        self.testRawValues()             // 原始值
//        self.testRecursiveEnumerations() // 枚举循环
    }
    
    // MARK: 枚举语法
    func testEnumerationSyntax() {
        
        // 使用
        var directionToHead = CompassPoint.West
        // 可不写.前面的枚举名
        directionToHead = .East
        print("\(directionToHead)")
        
    }
    
    // MARK: 枚举匹配
    func testMatchingEnumeration() {
        var directionToHead = CompassPoint.South
        // if匹配
        if directionToHead == CompassPoint.South {
            directionToHead = .East
        }
        // switch匹配
        switch directionToHead {
        case .North:
            print("Lots of planets have a north")
        case .South:
            print("Watch out for penguins")
        case .East:
            print("Where the sun rises")
        default:
            print("default")
        }
    }
    
    // MARK: 关联值
    func testAssociatedValues() {
        // 枚举可以和结构体类型的数据关联使用
        enum Barcode {
            case UPCA(Int, Int, Int, Int)
            case QRCode(String)
        }
        // 初始化
        var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
        productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
        // 匹配
        switch productBarcode {
        case .UPCA(let numberSystem, let manufacturer, let product, let check):
            print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .QRCode(let productCode):
            print("QR code: \(productCode).")
        }
        // 可以不写let
        switch productBarcode {
        case let .UPCA(numberSystem, manufacturer, product, check):
            print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .QRCode(productCode):
            print("QR code: \(productCode).")
        }
    }
    
    // MARK: 原始值
    func testRawValues() {
        enum ASCIIControlCharacter: Character {
            case Tab = "\t"
            case LineFeed = "\n"
            case CarriageReturn = "\r"
        }
        // 隐式分配原始值
        enum Planet: Int {
            case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
        }
        // 原始值为属性名转换
        enum CompassPoint: String {
            case North, South, East, West
        }
        print("\(Planet.Earth.rawValue)") // 3
        print("\(CompassPoint.West.rawValue)") // "West"
        
        // 通过原始值初始化
        let possiblePlanet = Planet(rawValue: 7)
        print("\(possiblePlanet)")
        let positionToFind = 9
        // 当原始值不匹配时，返回为nil
        if let somePlanet = Planet(rawValue: positionToFind) {
            switch somePlanet {
            case .Earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
        
    }
    
    // MARK: 枚举循环
    func testRecursiveEnumerations() {
        // indirect循环关键字
//        enum ArithmeticExpression {
//            case Number(Int)
//            indirect case Addition(ArithmeticExpression, ArithmeticExpression)
//            indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
//        }
        
        // 可将indirect写到枚举前
        indirect enum ArithmeticExpression {
            case Number(Int) // 值
            case Addition(ArithmeticExpression, ArithmeticExpression)       // 加
            case Multiplication(ArithmeticExpression, ArithmeticExpression) // 乘
        }
        // 函数使用
        func evaluate(expression: ArithmeticExpression) -> Int {
            switch expression {
            case .Number(let value):
                return value
            case .Addition(let left, let right):
                return evaluate(left) + evaluate(right)
            case .Multiplication(let left, let right):
                return evaluate(left) * evaluate(right)
            }
        }
        
        // evaluate (5 + 4) * 2
        let five = ArithmeticExpression.Number(5)
        let four = ArithmeticExpression.Number(4)
        let sum = ArithmeticExpression.Addition(five, four)
        let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
        print(evaluate(product))
        
    }
    
    
}
