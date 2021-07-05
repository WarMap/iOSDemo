//
//  MPRunloopObserver.m
//  Runloop
//
//  Created by 马鹏 on 2021/7/2.
//

#import "MPRunloopObserver.h"

@interface MPRunloopObserver () {
    CFRunLoopObserverRef m_runLoopBeginObserver;
    CFRunLoopObserverRef m_runLoopEndObserver;
    CFRunLoopObserverRef m_initializationBeginRunloopObserver;
    CFRunLoopObserverRef m_initializationEndRunloopObserver;
}

@end

#define RunLoopLog(frmt, ...) NSLog(@"runloop--" frmt, ##__VA_ARGS__)

@implementation MPRunloopObserver

+ (instancetype)beginObserver {
    MPRunloopObserver *ob = [[MPRunloopObserver alloc] init];
    [ob addRunLoopObserver];
    return ob;
}

- (void)dealloc {
    [self removeRunLoopObserver];
}

- (void)addRunLoopObserver {
    NSRunLoop *curRunLoop = [NSRunLoop currentRunLoop];

    // the first observer
    CFRunLoopObserverContext context = {0, (__bridge void *)self, NULL, NULL, NULL};
    CFRunLoopObserverRef beginObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, LONG_MIN, &myRunLoopBeginCallback, &context);
    CFRetain(beginObserver);
    m_runLoopBeginObserver = beginObserver;

    // the last observer
    CFRunLoopObserverRef endObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, LONG_MAX, &myRunLoopEndCallback, &context);
    CFRetain(endObserver);
    m_runLoopEndObserver = endObserver;

    CFRunLoopRef runloop = [curRunLoop getCFRunLoop];
    CFRunLoopAddObserver(runloop, beginObserver, kCFRunLoopCommonModes);
    CFRunLoopAddObserver(runloop, endObserver, kCFRunLoopCommonModes);

    // for InitializationRunLoopMode
    CFRunLoopObserverContext initializationContext = {0, (__bridge void *)self, NULL, NULL, NULL};
    m_initializationBeginRunloopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, LONG_MIN, &myInitializetionRunLoopBeginCallback, &initializationContext);
    CFRetain(m_initializationBeginRunloopObserver);

    m_initializationEndRunloopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, LONG_MAX, &myInitializetionRunLoopEndCallback, &initializationContext);
    CFRetain(m_initializationEndRunloopObserver);

    CFRunLoopAddObserver(runloop, m_initializationBeginRunloopObserver, (CFRunLoopMode) @"UIInitializationRunLoopMode");
    CFRunLoopAddObserver(runloop, m_initializationEndRunloopObserver, (CFRunLoopMode) @"UIInitializationRunLoopMode");
}

- (void)removeRunLoopObserver {
    NSRunLoop *curRunLoop = [NSRunLoop currentRunLoop];

    CFRunLoopRef runloop = [curRunLoop getCFRunLoop];
    CFRunLoopRemoveObserver(runloop, m_runLoopBeginObserver, kCFRunLoopCommonModes);
    CFRunLoopRemoveObserver(runloop, m_runLoopBeginObserver, (CFRunLoopMode) @"UIInitializationRunLoopMode");

    CFRunLoopRemoveObserver(runloop, m_runLoopEndObserver, kCFRunLoopCommonModes);
    CFRunLoopRemoveObserver(runloop, m_runLoopEndObserver, (CFRunLoopMode) @"UIInitializationRunLoopMode");
}


void myRunLoopBeginCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch (activity) {
        case kCFRunLoopEntry:
            RunLoopLog(@"begin---kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            RunLoopLog(@"begin---kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            RunLoopLog(@"begin---kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            RunLoopLog(@"begin---kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            RunLoopLog(@"begin---kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopAllActivities:
            RunLoopLog(@"begin---kCFRunLoopAllActivities");
            break;
        case kCFRunLoopExit:
            RunLoopLog(@"begin---kCFRunLoopExit");
            break;
        default:
            break;
    }
}

void myRunLoopEndCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{

    switch (activity) {
        case kCFRunLoopEntry:
            RunLoopLog(@"end---kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            RunLoopLog(@"end---kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            RunLoopLog(@"end---kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            RunLoopLog(@"end---kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            RunLoopLog(@"end---kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopAllActivities:
            RunLoopLog(@"end---kCFRunLoopAllActivities");
            break;
        case kCFRunLoopExit:
            RunLoopLog(@"end---kCFRunLoopExit");
            break;
        default:
            break;
    }
}

void myInitializetionRunLoopBeginCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch (activity) {
        case kCFRunLoopEntry:
            RunLoopLog(@"init-begin---kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            RunLoopLog(@"init-begin---kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            RunLoopLog(@"init-begin---kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            RunLoopLog(@"init-begin---kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            RunLoopLog(@"init-begin---kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopAllActivities:
            RunLoopLog(@"init-begin---kCFRunLoopAllActivities");
            break;
        case kCFRunLoopExit:
            RunLoopLog(@"init-begin---kCFRunLoopExit");
            break;
        default:
            break;
    }
}

void myInitializetionRunLoopEndCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{

    switch (activity) {
        case kCFRunLoopEntry:
            RunLoopLog(@"init-end---kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            RunLoopLog(@"init-end---kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            RunLoopLog(@"init-end---kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            RunLoopLog(@"init-end---kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            RunLoopLog(@"init-end---kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopAllActivities:
            RunLoopLog(@"init-end---kCFRunLoopAllActivities");
            break;
        case kCFRunLoopExit:
            RunLoopLog(@"init-end---kCFRunLoopExit");
            break;
        default:
            break;
    }
}
@end
