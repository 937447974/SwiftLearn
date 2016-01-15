//
//  ViewController.swift
//  YJImageIO
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/14.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if var image = UIImage(named: "Image") {
            if var data = UIImageJPEGRepresentation(image, 1.0) {
                print(data.length)
                data = UIImageJPEGRepresentation(UIImage(named: "Image")!, 0)!
                print(data.length)
                image = UIImage(data: data)!
                data = UIImagePNGRepresentation(UIImage(named: "Image")!)!
                print(data.length)
                image = UIImage(data: data)!
                image = YJUtilsImageIO.createThumbnailImageFromImage(image)!
            }
            let imageView = UIImageView(image: image)
            imageView.frame = self.view.frame
            self.view.addSubview(imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

