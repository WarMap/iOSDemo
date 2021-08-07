//
//  MPSomeTask.m
//  Thread
//
//  Created by 马鹏 on 2021/8/7.
//

#import "MPSomeTask.h"
#include <pthread.h>
#include <mach/mach.h>

@interface MPSomeTask()<NSPortDelegate> {
    NSThread *_thread;
    NSPort *mainPort;
}

@property (nonatomic, weak) NSRunLoop *loop;

@end

@implementation MPSomeTask

- (instancetype)initWithPort:(NSPort *)port {
    self = [super init];
    if (self) {
        _port = [NSMachPort port];
        _port.delegate = self;
        mainPort = port;
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(subThreadEntrance) object:nil];
        _thread.name = @"subThread";
        [_thread start];
    }
    return self;
}

- (void)handleMachMessage:(void *)msg {
    NSLog(@"subThread callback---");
    NSThread* thread = [NSThread currentThread];
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    NSLog(@"current thread num: %x thread name:%@", machTID,thread.name);
    NSLog(@"---------------------");
}

- (void)subThreadEntrance {
    [[NSRunLoop currentRunLoop] addPort:_port forMode:NSRunLoopCommonModes];
    NSLog(@"---------------------");
    self.loop = [NSRunLoop currentRunLoop];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    NSThread* thread = [NSThread currentThread];
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    NSLog(@"current thread num: %x thread name:%@", machTID,thread.name);
    NSLog(@"loop was killed ---------------------");
}

- (void)runPort {
    [self performSelector:@selector(firePort) onThread:_thread withObject:nil waitUntilDone:NO];

}


- (void)firePort {
    NSData *data1 = [@"warmap" dataUsingEncoding:NSUTF8StringEncoding];
    NSThread* thread = [NSThread currentThread];
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    NSLog(@"current thread num: %x thread name:%@", machTID,thread.name);
    [mainPort sendBeforeDate:[NSDate date] msgid:198239 components:@[data1, _port].mutableCopy from:_port reserved:2];
}

- (void)killThread {
    [self.loop removePort:_port forMode:NSRunLoopCommonModes];
}

@end
