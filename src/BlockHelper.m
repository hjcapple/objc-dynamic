//
//  BlockHelper.m
//  example
//
//  Created by HJC on 2018/6/17.
//  Copyright © 2018年 HJC. All rights reserved.
//

#import "BlockHelper.h"

enum {
    BLOCK_HAS_COPY_DISPOSE = (1 << 25), // compiler
    BLOCK_HAS_SIGNATURE = (1 << 30)     // compiler
};

struct Block_descriptor {
    unsigned long int reserved;
    unsigned long int size;

    // requires BLOCK_HAS_COPY_DISPOSE
    void (*copy)(void *dst, const void *src);
    void (*dispose)(const void *);

    // requires BLOCK_HAS_SIGNATURE
    const char *signature;
    const char *layout;
};

struct Block_layout {
    void *isa;
    volatile int flags; // contains ref count
    int reserved;
    void (*invoke)(void *, ...);
    struct Block_descriptor *descriptor;
    // imported variables
};

@implementation BlockHelper

+ (NSMethodSignature *)methodSignatureFromBlock:(id)block {
    struct Block_layout *layout = (__bridge void *)block;
    if (!(layout->flags & BLOCK_HAS_SIGNATURE)) {
        return nil;
    }
    void *desc = layout->descriptor;
    desc += 2 * sizeof(unsigned long int);
    if (layout->flags & BLOCK_HAS_COPY_DISPOSE) {
        desc += 2 * sizeof(void *);
    }

    if (!desc) {
        return nil;
    }
    const char *signature = (*(const char **)desc);
    return [NSMethodSignature signatureWithObjCTypes:signature];
}

@end
