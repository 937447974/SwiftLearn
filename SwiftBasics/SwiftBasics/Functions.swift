//
//  Functions.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/27.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 函数
class Functions: TestProtocol {
    
    func test() {
//        self.testDefiningAndCallingFunctions()       // 定义和调用函数
//        self.testFunctionParametersAndReturnValues() // 参数和返回值
//        self.testParameterNames()                    // 参数名
//        self.testFunctionTypes()                     // 函数类型
//        self.testNestedFunctions()                   // 嵌套函数
    }
    
    // MARK: - 定义和调用函数
    func testDefiningAndCallingFunctions() {
        func sayHello(_ personName: String) -> String {
            let greeting = "Hello, " + personName + "!"
            return greeting
        }
        print(sayHello("阳君"))
        // prints "Hello, 阳君!"
    }
    
    // MARK: - 函数参数和返回值
    func testFunctionParametersAndReturnValues() {
        self.testFunctionsWithoutParameters()
        self.testFunctionsWithMultipleParameters()
        self.testFunctionsWithoutReturnValues()
        self.testMultipleReturnValues()
        self.testOptionalTupleReturnTypes()
    }
    
    // MARK: 无参数函数
    func testFunctionsWithoutParameters() {
        // 无参数，只有一个String类型的返回值
        func sayHelloWorld() -> String {
            return "hello, world"
        }
        print(sayHelloWorld())
        // prints "hello, world"
    }
    
    // MARK:多参数函数
    func testFunctionsWithMultipleParameters() {
        // 传入两个参数，并返回一个String类型的数据
        func sayHello(_ personName: String, alreadyGreeted: Bool) -> String {
            if alreadyGreeted {
                return "Hello again, \(personName)!"
            } else {
                return "Hello, \(personName)!"
            }
        }
        print(sayHello("阳君", alreadyGreeted: true))
        // prints "Hello again, 阳君!"
    }
    
    // MARK: 函数无返回值
    func testFunctionsWithoutReturnValues() {
        // 传入一个String类型的数据，不返回任何数据
        func sayGoodbye(_ personName: String) {
            print("Goodbye, \(personName)!")
        }
        sayGoodbye("阳君") // prints "Goodbye, 阳君!"
    }
    
    // MARK: 函数多返回值
    func testMultipleReturnValues() {
        // 返回一个Int类型的数据
        func printAndCount(_ stringToPrint: String) -> Int {
            print(stringToPrint)
            return stringToPrint.characters.count
        }
        printAndCount("hello, world") // prints "hello, world"
        // 返回元组合数据
        func minMax(_ array: [Int]) -> (min: Int, max: Int) {
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }
        let bounds = minMax([8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
        // prints "min is -6 and max is 109"
    }
    
    // MARK: 返回类型可选
    func testOptionalTupleReturnTypes() {
        // 返回一个元组或Nil
        func minMax(_ array: [Int]) -> (min: Int, max: Int)? {
            if array.isEmpty {
                return nil
            }
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }
        if let bounds = minMax([8, -6, 2, 109, 3, 71]) {
            print("min is \(bounds.min) and max is \(bounds.max)")
            // prints "min is -6 and max is 109"
        }
    }
    
    // MARK: - 参数名
    func testParameterNames() {
        self.testSpecifyingExternalParameterNames() // 指定外部参数名
        self.testOmittingExternalParameterNames()   // 省略外部参数名
        self.testDefaultParameterValues()           // 默认参数值
        self.testVariadicParameters()               // 可变参数
        self.testConstantAndVariableParameters()    // 常量和变量参数
        self.testInOutParameters()                  // In-Out参数
    }
    
    // MARK: 指定外部参数名
    func testSpecifyingExternalParameterNames() {
        // 指定外部参数名to和and
        func sayHello(to person: String, and anotherPerson: String) -> String {
            return "Hello \(person) and \(anotherPerson)!"
        }
        print(sayHello(to: "Bill", and: "Ted"))
        // prints "Hello Bill and Ted!"
    }
    
    // MARK: 省略外部参数名
    func testOmittingExternalParameterNames() {
        // 使用_省略外面参数名，
        func someFunction(_ firstParameterName: Int, _ secondParameterName: Int) {
            
        }
        someFunction(1, 2)
    }
    
    // MARK: 默认参数值
    func testDefaultParameterValues() {
        // 设置默认值，当用户不传入时，使用默认值
        func someFunction(_ parameterWithDefault: Int = 12) {
            print("\(parameterWithDefault)")
        }
        someFunction(6) // 6
        someFunction() // 12
    }
    
    // MARK: 可变参数
    func testVariadicParameters() {
        // 传入的参数类型已知Double，个数未知
        func arithmeticMean(_ numbers: Double...) -> Double {
            var total: Double = 0
            for number in numbers {
                total += number
            }
            return total / Double(numbers.count)
        }
        print("\(arithmeticMean(1, 2, 3, 4, 5))") // 3.0
        print("\(arithmeticMean(3, 8.25, 18.75))") // 10.0
    }
    
    // MARK: 常量和变量参数
    func testConstantAndVariableParameters() {
        // 默认为let常量参数，也可声明var可变参数，在函数内直接修改
        func alignRight(_ string: String, totalLength: Int, pad: Character) -> String {
            var string = string
            let amountToPad = totalLength - string.characters.count
            if amountToPad < 1 {
                return string
            }
            let padString = String(pad)
            for _ in 1...amountToPad {
                string = padString + string
            }
            return string
        }
        let originalString = "hello"
        let paddedString = alignRight(originalString, totalLength: 10, pad: "-")
        print("originalString:\(originalString); paddedString:\(paddedString);")
        // originalString:hello; paddedString:-----hello;
    }
    
    // MARK: In-Out参数
    func testInOutParameters() {
        // 使用inout声明的参数，在函数内修改参数值时，外面参数值也会变
        func swapTwoInts(_ a: inout Int, _ b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        // prints "someInt is now 107, and anotherInt is now 3"
    }
    
    // MARK: - 函数类型
    func testFunctionTypes() {
        self.testUsingFunctionTypes()            // 使用函数类型
        self.testFunctionTypesAsParameterTypes() // 函数做参数类型
        self.testFunctionTypesAsReturnTypes()    // 函数做返回类型
    }
    
    // MARK: 使用函数类型
    func testUsingFunctionTypes() {
        // 加法
        func addTwoInts(_ a: Int, _ b: Int) -> Int {
            return a + b
        }
        // 乘法
        func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
            return a * b
        }
        // 函数体赋值为参数
        var mathFunction: (Int, Int) -> Int = addTwoInts
        print("Result: \(mathFunction(2, 3))") // prints "Result: 5"
        // 函数体指向替换
        mathFunction = multiplyTwoInts
        print("Result: \(mathFunction(2, 3))") // prints "Result: 6"
        // 函数体传递
        let anotherMathFunction = addTwoInts //
        // anotherMathFunction is inferred to be of type (Int, Int) -> Int
        print("\(anotherMathFunction)")
    }
    
    // MARK: 函数做参数类型
    func testFunctionTypesAsParameterTypes() {
        // 加法
        func addTwoInts(_ a: Int, _ b: Int) -> Int {
            return a + b
        }
        // 其中一个参数为一个函数体
        func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
            print("Result: \(mathFunction(a, b))")
        }
        printMathResult(addTwoInts, 3, 5) // prints "Result: 8"
    }
    
    // MARK: 函数做返回类型
    func testFunctionTypesAsReturnTypes() {
        // 加1
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }
        // 减1
        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }
        // 使用函数体做返回类型
        func chooseStepFunction(_ backwards: Bool) -> (Int) -> Int {
            return backwards ? stepBackward : stepForward
        }
        var currentValue = 3
        // 此时moveNearerToZero指向stepForward函数
        let moveNearerToZero = chooseStepFunction(currentValue > 0)
        // 调用函数体
        currentValue = moveNearerToZero(currentValue)
        print("\(currentValue)... ") // prints “2...”
    }
    
    // MARK: - 嵌套函数
    func testNestedFunctions() {
        // 函数体内部嵌套函数，并做返回类型
        func chooseStepFunction(_ backwards: Bool) -> (Int) -> Int {
            // 嵌套函数1
            func stepForward(_ input: Int) -> Int {
                stepBackward(1)
                return input + 1
            }
            // 嵌套函数2
            func stepBackward(_ input: Int) -> Int {
                return input - 1
            }
            return backwards ? stepBackward : stepForward
        }
        var currentValue = -2
        let moveNearerToZero = chooseStepFunction(currentValue > 0)
        currentValue = moveNearerToZero(currentValue)
        print("\(currentValue)... ") // prints "-1..."
    }
    
}
