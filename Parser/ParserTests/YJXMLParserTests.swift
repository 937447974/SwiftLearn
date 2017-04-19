//
//  YJXMLParserTests.swift
//  Parser
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/7.
//  Copyright © 2015年 阳君. All rights reserved.
//

import XCTest

/// xml解析
class YJXMLParserTests: XCTestCase, XMLParserDelegate {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        if let url = Bundle.main.url(forResource: "Main", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: url) {
                parser.shouldProcessNamespaces = false;
                parser.delegate = self;
                parser.parse()
            }
        }
    }
    
    // MARK: - NSXMLParserDelegate
    // MARK: 解析开始
    func parserDidStartDocument(_ parser: XMLParser) {
        print(#function)
    }
    
    // MARK: 解析结束
    func parserDidEndDocument(_ parser: XMLParser) {
        print(#function)
    }
    
    // MARK: 解析出错
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("解析错误\(parseError.localizedDescription)")
    }
    
    // MARK: 解析器每次在XML中找到新的元素时，会调用该方法
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("\(elementName) - \(namespaceURI ?? "") - \(qName ?? "") - \(attributeDict)")
    }
    
}
