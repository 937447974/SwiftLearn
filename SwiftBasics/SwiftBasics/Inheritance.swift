//
//  Inheritance.swift
//  SwiftBasics
//
//  Created by yangjun on 15/10/30.
//  Copyright © 2015年 六月. All rights reserved.
//

/// 继承
class Inheritance: TestProtocol {

    func test() {
        self.testInheritance()
    }
    
    func testInheritance() {
        
        /// 基类
        class Base {
            var count = 0.0
            var description: String {
                return "count:\(count)"
            }
            
            // MARK: 可继承
            func inherited() {
                
            }
            
            // MARK: 防止继承
            final func preventing() {
                // 如果不想子类继承，可在类、属性或方法前添加final
                
            }
        }
        
        
        /// 子类
        class Subclass: Base {
    
            // 继承的属性和方法前都有override
            override var count:Double {
                didSet {
                    print("\(#function)")
                }
            }
            
            override var description: String {
                return "\(#function)" + super.description
            }
    
            override func inherited() {
                print("\(#function)")
            }
        }
        
        let subclass = Subclass()
        subclass.count = 10              // print "count"
        print("\(subclass.description)") // print "descriptioncount:10.0"
        subclass.inherited()             // print "inherited()"
    }
}
