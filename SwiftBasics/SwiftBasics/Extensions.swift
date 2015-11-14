//
//  Extensions.swift
//  SwiftBasics
//
//  Created by yangjun on 15/11/1.
//  Copyright © 2015年 六月. All rights reserved.
//


extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

/// 扩展
class Extensions: TestProtocol {

    func test() {
       
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        // prints "One inch is 0.0254 meters"
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        // prints "Three feet is 0.914399970739201 meters"
        
    }
}
