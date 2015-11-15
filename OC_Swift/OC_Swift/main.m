//
//  main.m
//  OC_Swift
//
//  Created by 阳君 on 14/11/11.
//  Copyright (c) 2014年 北京宏景世纪软件股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OC_Swift-Swift.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 混编Swift
        Swift *swift = [[Swift alloc] init];
        [swift test:@"yangj"];
    }
    return 0;
}
