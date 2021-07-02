//
//  MPLRSource.m
//  Runloop
//
//  Created by 马鹏 on 2021/5/30.
//

#import "MPLRSource.h"
#import "base.h"
#include <CoreFoundation/CFRunLoop.h>
#include <Block.h>
#include <objc/runtime.h>
#include <objc/message.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
/// Private Headers
#include "base.h"

static inline void run_objc_inspect(void);

static inline void runLoop_source_perform(void *info) {
    let perform = (__bridge void (^)(void))info;
    !perform ?: (perform)();
    run_objc_inspect();
}

static let runLoop_get_source = ^(id perform_block) {
    static var src_0 = (CFRunLoopSourceRef)nil;
    var src_ctx = (CFRunLoopSourceContext) {
        0, (__bridge void *)(perform_block), nil, nil, nil, nil, nil, nil, nil, runLoop_source_perform
    };
    if (src_0 != nil) {
        CFRunLoopSourceGetContext(src_0, &src_ctx);
        src_ctx.info = (__bridge void *)(perform_block);
        goto done;
    }
    src_0 = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &src_ctx);
done:
    return src_0;
};

let objc_inspect = ^{
    
    printf("Please specify which Class to be inspect: ");
    let buf_size = (size_t)100;
    let c_str = (char *)malloc(sizeof(char) * buf_size);
    defer {
        free(c_str);
    };
    fgets(c_str, buf_size, stdin);
    
    let sel_str = (char *)malloc(sizeof(char) *buf_size);
    goto input;
    do {
    
    input:
        printf("Please specify sel, type enter for terminate: ");
        fgets(sel_str, buf_size, stdin);
    } while (strtok(sel_str, "\n"));
    
    printf("Awaiting for next inspection \n\n");
};

static inline void run_objc_inspect(void) {
    //函数指针
    let copyed_blk = _Block_copy((__bridge const void *)((id)objc_inspect));
    
    let src_0 = runLoop_get_source((__bridge id)(copyed_blk));
    if (CFRunLoopContainsSource(CFRunLoopGetCurrent(), src_0, kCFRunLoopDefaultMode)) {
        goto done;
    }
    CFRunLoopAddSource(CFRunLoopGetCurrent(), src_0, kCFRunLoopDefaultMode);
done:
    CFRunLoopSourceSignal(src_0);
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
}

@implementation MPLRSource

+ (void)run {
    run_objc_inspect();
    CFRunLoopRun();
}
@end
