//
//  OptionalChaining.swift
//  SwiftBasics
//
//  Created by yangjun on 15/11/1.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 可选链
class OptionalChaining: TestProtocol {

    func test() {
        class Person {
            // 可选属性，可能为nil或Residence类
            var residence: Residence?
        }
        
        class Residence {
            var numberOfRooms = 1
        }
        
        let john = Person()
        john.residence = Residence()
        
        // 可选获得
        var roomCount = john.residence?.numberOfRooms
        // 强制获得
        roomCount = john.residence!.numberOfRooms
        print(roomCount) // Optional(1) Optional代表可选
        // if获得
        if let roomCount = john.residence?.numberOfRooms {
            print(roomCount) // 1
        }
    }
    
}
