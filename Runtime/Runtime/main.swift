//
//  main.swift
//  Runtime
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/11.
//  Copyright © 2016年 阳君. All rights reserved.
//

import Foundation

let user = YJUser()
user.name = "阳君"
print(user.name ?? "")
user.cleanParameter()
print(user.name ?? "")
