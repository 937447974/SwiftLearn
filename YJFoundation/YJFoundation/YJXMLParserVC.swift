//
//  YJXMLParserVC.swift
//  YJFoundation
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSXMLParser解析XML
class YJXMLParserVC: UIViewController, NSXMLParserDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSBundle.mainBundle().URLForResource("Main", withExtension: "xml") {
            if let parser = NSXMLParser(contentsOfURL: url) {
                parser.shouldProcessNamespaces = false;
                parser.delegate = self;
                parser.parse()
            }
        }
    }
    
    // MARK: - NSXMLParserDelegate
    // MARK: 解析开始
    func parserDidStartDocument(parser: NSXMLParser) {
        print(__FUNCTION__)
    }
    
    // MARK: 解析结束
    func parserDidEndDocument(parser: NSXMLParser) {
        print(__FUNCTION__)
    }
    
    // MARK: 解析出错
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("解析错误\(parseError.localizedDescription)")
    }
    
    // MARK: 解析器每次在XML中找到新的元素时，会调用该方法
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("\(elementName) - \(namespaceURI) - \(qName) - \(attributeDict)")
    }

}
