//
//  SafeProtocol.m
//  example
//
//  Created by HJC on 2018/6/19.
//  Copyright © 2018年 HJC. All rights reserved.
//

#import "SafeProtocol.h"
#import <objc/runtime.h>

@implementation SafeProtocol {
    id _target;
    Protocol *_protocol;
}

- (instancetype)initWithProtocol:(Protocol *)protocol target:(id)target {
    if (self = [super init]) {
        _target = target;
        _protocol = protocol;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([_target respondsToSelector:aSelector]) {
        return _target;
    }
    return nil;
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    // do nothing
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        return;
    }

    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    [anInvocation setReturnValue:buffer];
}

static NSMethodSignature *methodSignatureForSelectorFromProtocol(SEL selector, Protocol *protocol) {
    struct objc_method_description description = protocol_getMethodDescription(protocol, selector, NO, YES);
    if (description.types) {
        return [NSMethodSignature signatureWithObjCTypes:description.types];
    }

    description = protocol_getMethodDescription(protocol, selector, YES, YES);
    if (description.types) {
        return [NSMethodSignature signatureWithObjCTypes:description.types];
    }
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *methodSignature = [_target methodSignatureForSelector:selector];
    if (methodSignature == nil) {
        methodSignature = methodSignatureForSelectorFromProtocol(selector, _protocol);
    }
    NSAssert(methodSignature, @"");
    return methodSignature;
}

@end
