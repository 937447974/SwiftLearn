//
//  YJXMLParserVC.swift
//  YJFoundation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSXMLParser解析XML
class YJXMLParserVC: UIViewController, XMLParserDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        print("\(elementName) - \(namespaceURI) - \(qName) - \(attributeDict)")
    }

}
