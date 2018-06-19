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
#import "SafeProtocol.h"

@protocol TestProtocol<NSObject>
@optional
- (void) funA;
- (void) funB;
@end

@interface TestObject : NSObject<TestProtocol>
@end

@implementation TestObject

- (void) funA {
    NSLog(@"%@", @"TestObject, funA");
}
@end

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        void (^block)(int a, int b) = ^(int a, int b) {
        };

        NSMethodSignature *signature = [BlockHelper methodSignatureFromBlock:block];
        NSLog(@"%@", [signature debugDescription]);
        
        TestObject* obj = [[TestObject alloc] init];
        [SAFE_PROTOCOL(TestProtocol, obj) funA];
        [SAFE_PROTOCOL(TestProtocol, obj) funB];
    }
    return 0;
}
