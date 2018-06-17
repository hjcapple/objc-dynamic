//
//  main.m
//  example
//
//  Created by HJC on 2018/6/17.
//  Copyright © 2018年 HJC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Block_private.h"
#import "BlockHelper.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        void (^block)(int a, int b) = ^(int a, int b) {
        };

        NSMethodSignature *signature = [BlockHelper methodSignatureFromBlock:block];
        NSLog(@"%@", [signature debugDescription]);
    }
    return 0;
}
