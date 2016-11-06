//
//  ViewController.swift
//  urlTest
//
//  Created by admin on 2016/11/4.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://www.baidu.com") else {
            return;
        }
        self.webView.loadRequest(URLRequest(url: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

