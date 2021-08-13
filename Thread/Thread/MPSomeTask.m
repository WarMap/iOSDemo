//
//  MPSomeTask.m
//  Thread
//
//  Created by 马鹏 on 2021/8/7.
//

#import "MPSomeTask.h"
#import "MPThread.h"
#import "MPThreadUtil.h"

@interface MPSomeTask()<NSPortDelegate> {
    MPThread *_thread;
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
        _thread = [[MPThread alloc] init];
        _thread.name = @"subThread";
    }
    return self;
}

- (void)handleMachMessage:(void *)msg {
    currentThreadInfo(@"receive");
}

- (void)runPort {
    [self performSelector:@selector(firePort) onThread:_thread withObject:nil waitUntilDone:NO];
}

- (void)firePort {
    currentThreadInfo(@"fire   ");
    NSData *data1 = [@"warmap" dataUsingEncoding:NSUTF8StringEncoding];
    [mainPort sendBeforeDate:[NSDate date] msgid:198239 components:@[data1, _port].mutableCopy from:_port reserved:2];
}

- (void)killThread {
    [self.loop removePort:_port forMode:NSRunLoopCommonModes];
    CFRunLoopStop([self.loop getCFRunLoop]);
    NSLog(@"loop %@", self.loop);
}

@end
