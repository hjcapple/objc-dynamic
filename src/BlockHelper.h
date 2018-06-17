//
//  BlockHelper.h
//  example
//
//  Created by HJC on 2018/6/17.
//  Copyright © 2018年 HJC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockHelper : NSObject

+ (NSMethodSignature *)methodSignatureFromBlock:(id)block;

@end
