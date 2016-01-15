//
//  YJUtilsImageIO.swift
//  YJImageIO
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/14.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import ImageIO

/// ImageIO库工具类
public struct YJUtilsImageIO {
    
    // MARK: - 
    /// 获取UIImage的缩略图
    static func createThumbnailImageFromImage(image: UIImage) -> UIImage? {
        guard let data = UIImagePNGRepresentation(image) else {
            return nil
        }
        guard let cgImage = YJUtilsImageIO.createThumbnailImageFromData(data, imageSize: data.length) else {
            return nil
        }
        return UIImage(CGImage: cgImage)
    }
    
    /// 获取UIImage的缩略图
    static func createThumbnailImageFromData(data: NSData, var imageSize: Int) -> CGImageRef? {
        // Create an image source from NSData; no options.
        // Make sure the image source exists before continuing.
        guard let imageSource = CGImageSourceCreateWithData(data as CFDataRef, nil) else {
            print("Image source is NULL.")
            return nil
        }
        // Package the integer as a  CFNumber object. Using CFTypes allows you to more easily create the options dictionary later.
        let thumbnailSize: CFNumberRef = CFNumberCreate(kCFAllocatorDefault, CFNumberType.IntType, &imageSize)
        // Set up the thumbnail options.
        let keys: [CFStringRef] = [kCGImageSourceCreateThumbnailWithTransform, kCGImageSourceCreateThumbnailFromImageIfAbsent, kCGImageSourceThumbnailMaxPixelSize]
        let values:[CFTypeRef] = [kCFBooleanTrue, kCFBooleanTrue , thumbnailSize]
        var kcBacks = kCFTypeDictionaryKeyCallBacks
        var vcBacks = kCFTypeDictionaryValueCallBacks
        let options: CFDictionaryRef = CFDictionaryCreate(kCFAllocatorDefault, UnsafeMutablePointer(UnsafePointer<Void>(keys)), UnsafeMutablePointer(UnsafePointer<Void>(values)), 2, &kcBacks, &vcBacks)
        // Create the thumbnail image using the specified options.
        let thumbnailImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options)
        // Release the options dictionary and the image source, when you no longer need them.
        /* swift 废弃
        CFRelease(thumbnailSize)
        CFRelease(options)
        CFRelease(imageSource)
        */
        // Make sure the thumbnail image exists before continuing.
        guard thumbnailImage != nil else {
            print("Thumbnail image not created from image source.")
            return nil
        }
        return thumbnailImage
    }
    
}
