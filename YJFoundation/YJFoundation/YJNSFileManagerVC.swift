//
//  YJNSFileManagerVC.swift
//  YJFoundation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by admin on 16/3/20.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSFileManager
class YJNSFileManagerVC: UIViewController {
    
    let fileMagager = FileManager.default

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testCreatingAFileManager()
        self.testLocatingSystemDirectories()
        self.testLocatingApplicationGroupContainerDirectories()
        self.testDiscoveringDirectoryContents()
        self.testMovingAndCopyingItems()
        self.testManagingiCloudBasedItems()
        self.testCreatingSymbolicAndHardLinks()
        self.testDeterminingAccessToFiles()
        self.testGettingAndSettingAttributes()
        self.testGettingAndComparingFileContents()
        self.testGettingTheRelationshipBetweenItems()
        self.testConvertingFilePathsToStrings()
        self.testManagingTheDelegate()
        self.testManagingTheCurrentDirectory()
        self.testDeprecatedMethods()
    }

    func testCreatingAFileManager() {
        let fileMagager = FileManager.default
        print(fileMagager)
    }
    
    func testLocatingSystemDirectories() {
        // 获取tmp目录
        let tmpURL = fileMagager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: .userDomainMask).first
        print(tmpURL)
        // tmp下创建临时目录
        do {
            let createURL = try fileMagager.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: tmpURL, create: true)
            print(createURL)
        } catch {
            // 在捕获中，隐式携带error错误。
            print("未知错误：\(error)")
        }        
    }
    
    func testLocatingApplicationGroupContainerDirectories() {
        // 定位应用组目录，需在https://idmsa.apple.com/IDMSWebAuth/authenticate配置
        let groupURL = self.fileMagager.containerURL(forSecurityApplicationGroupIdentifier: "idebtufuer")
        print(groupURL)
    }
    
    func testDiscoveringDirectoryContents() {
        print(try? self.fileMagager.contentsOfDirectory(atPath: YJUtilsDirectory.homePath))
        let enumerator = self.fileMagager.enumerator(atPath: YJUtilsDirectory.homePath)
        for url in enumerator! {
            print(url)
        }
        print(self.fileMagager.subpaths(atPath: YJUtilsDirectory.homePath))
        print(try? self.fileMagager.subpathsOfDirectory(atPath: YJUtilsDirectory.homePath))
    }
    

    
    func testMovingAndCopyingItems() {
        
    }
    
    func testManagingiCloudBasedItems() {
        
    }
    
    func testCreatingSymbolicAndHardLinks() {
        
    }
    
    func testDeterminingAccessToFiles() {
        
    }
    
    func testGettingAndSettingAttributes() {
        
    }
    
    func testGettingAndComparingFileContents() {
        
    }
    
    func testGettingTheRelationshipBetweenItems() {
        
    }
    
    func testConvertingFilePathsToStrings() {
        
    }
    
    func testManagingTheDelegate() {
        
    }
    
    func testManagingTheCurrentDirectory() {
        
    }
    
    func testDeprecatedMethods() {
        
    }
    
   

    
//    @available(iOS 4.0, *)
//    public func mountedVolumeURLsIncludingResourceValuesForKeys(propertyKeys: [String]?, options: NSVolumeEnumerationOptions) -> [NSURL]?
//    
//    @available(iOS 8.0, *)
//    public func getRelationship(outRelationship: UnsafeMutablePointer<NSURLRelationship>, ofDirectoryAtURL directoryURL: NSURL, toItemAtURL otherURL: NSURL) throws
//    

//    @available(iOS 8.0, *)
//    public func getRelationship(outRelationship: UnsafeMutablePointer<NSURLRelationship>, ofDirectory directory: NSSearchPathDirectory, inDomain domainMask: NSSearchPathDomainMask, toItemAtURL url: NSURL) throws
    
//    @available(iOS 5.0, *)
//    public func createSymbolicLinkAtURL(url: NSURL, withDestinationURL destURL: NSURL) throws
//
//    @available(iOS 2.0, *)
//    unowned(unsafe) public var delegate: NSFileManagerDelegate?
//
//    @available(iOS 2.0, *)
//    public func setAttributes(attributes: [String : AnyObject], ofItemAtPath path: String) throws
    
//    @available(iOS 2.0, *)
//    public func attributesOfItemAtPath(path: String) throws -> [String : AnyObject]
//    
//    @available(iOS 2.0, *)
//    public func attributesOfFileSystemForPath(path: String) throws -> [String : AnyObject]
//    
//    @available(iOS 2.0, *)
//    public func createSymbolicLinkAtPath(path: String, withDestinationPath destPath: String) throws
//    
//    @available(iOS 2.0, *)
//    public func destinationOfSymbolicLinkAtPath(path: String) throws -> String
//
//    @available(iOS 2.0, *)
//    public func linkItemAtPath(srcPath: String, toPath dstPath: String) throws

    //    @available(iOS 4.0, *)
//    public func linkItemAtURL(srcURL: NSURL, toURL dstURL: NSURL) 
    
//    public var currentDirectoryPath: String { get }
//    public func changeCurrentDirectoryPath(path: String) -> Bool
//
//    public func fileExistsAtPath(path: String) -> Bool
//    public func fileExistsAtPath(path: String, isDirectory: UnsafeMutablePointer<ObjCBool>) -> Bool
//    public func isReadableFileAtPath(path: String) -> Bool
//    public func isWritableFileAtPath(path: String) -> Bool
//    public func isExecutableFileAtPath(path: String) -> Bool
//    public func isDeletableFileAtPath(path: String) -> Bool
//    

//    public func contentsEqualAtPath(path1: String, andPath path2: String) -> Bool

//    public func displayNameAtPath(path: String) -> String
//
//    public func componentsToDisplayForPath(path: String) -> [String]?

//    public func contentsAtPath(path: String) -> NSData?

//    public func fileSystemRepresentationWithPath(path: String) -> UnsafePointer<Int8>
//
//    public func stringWithFileSystemRepresentation(str: UnsafePointer<Int8>, length len: Int) -> String
    
}
