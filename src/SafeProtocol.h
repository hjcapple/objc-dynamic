//
//  SafeProtocol.h
//  example
//
//  Created by HJC on 2018/6/19.
//  Copyright © 2018年 HJC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafeProtocol : NSObject {
}
- (instancetype)initWithProtocol:(Protocol *)protocol target:(id)target;
@end

#define SAFE_PROTOCOL(__protocolName, __target)                                                                  \
    ({                                                                                                           \
        SafeProtocol *__obj = [[SafeProtocol alloc] initWithProtocol:@protocol(__protocolName) target:__target]; \
        (id<__protocolName>)__obj;                                                                               \
    })
