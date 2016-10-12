//
//  AdvancedOperators.swift
//  SwiftBasics
//
//  Created by yangjun on 15/11/2.
//  Copyright © 2015年 六月. All rights reserved.
//

struct Vector2D {
    var x = 0.0, y = 0.0
}

/// 符号在中间
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

/// 符号在前
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

postfix func -- (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

prefix func ++ (vector: inout Vector2D) -> Vector2D {
    vector = vector + Vector2D(x: 1.0, y: 1.0)
    return vector
}

func += (left: inout Vector2D, right: Vector2D) {
    left = left + right
}



/// 高级操作符
class AdvancedOperators: TestProtocol {

    func test() {
        
        // ~ 取反
        let initialBits: UInt8 = 0b00001111
        let invertedBits = ~initialBits  // equals 11110000
        
        // & 同1取1
        let firstSixBits: UInt8 = 0b11111100
        let lastSixBits: UInt8  = 0b00111111
        let middleFourBits = firstSixBits & lastSixBits  // equals 00111100

        // | 有1取1
        let someBits: UInt8 = 0b10110010
        let moreBits: UInt8 = 0b01011110
        let combinedbits = someBits | moreBits  // equals 11111110

        // ^ 相异取1
        let firstBits: UInt8 = 0b00010100
        let otherBits: UInt8 = 0b00000101
        let outputBits = firstBits ^ otherBits  // equals 00010001

        // >>右移；<<左移
        let shiftBits: UInt8 = 4   // 00000100 in binary
        var bit = shiftBits << 1             // 00001000
        bit = shiftBits << 2             // 00010000
        bit = shiftBits << 5             // 10000000
        bit = shiftBits << 6             // 00000000
        bit = shiftBits >> 2             // 00000001

        let vector = Vector2D(x: 3.0, y: 1.0)
        let anotherVector = Vector2D(x: 2.0, y: 4.0)
        let combinedVector = vector + anotherVector
        // combinedVector is a Vector2D instance with values of (5.0, 5.0)
        
        let positive = Vector2D(x: 3.0, y: 4.0)
        let negative = -positive
        // negative is a Vector2D instance with values of (-3.0, -4.0)
        let alsoPositive = -negative
        // alsoPositive is a Vector2D instance with values of (3.0, 4.0)
        
        var toIncrement = Vector2D(x: 3.0, y: 4.0)
        let afterIncrement = ++toIncrement
        // toIncrement now has values of (4.0, 5.0)
        // afterIncrement also has values of (4.0, 5.0)
        
        var original = Vector2D(x: 1.0, y: 2.0)
        let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
        original += vectorToAdd

    }
}
