//
//  MPThread.m
//  Thread
//
//  Created by 马鹏 on 2021/8/8.
//

#import "MPThread.h"

@interface MPThread ()

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, copy) dispatch_block_t task;
@property (nonatomic, assign) BOOL stoped;

@end

@implementation MPThread

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(id)argument {
    self = [self init];
    if (self) {
        [target performSelector:selector onThread:self.thread withObject:argument waitUntilDone:NO];
    }
    return self;
}

- (void)setup {
    self.lock = [[NSLock alloc] init];
    __weak typeof(self) weakSelf = self;
    self.thread = [[NSThread alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        while (weakSelf) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"loop is exited-------------------------");
    }];
    [self.thread start];
}

- (void)setName:(NSString *)name {
    self.thread.name = name;
}

- (NSString *)name {
    return self.thread.name;
}

- (void)stop {
    if (self.stoped) {
        return;
    }
    [self performSelector:@selector(stopLoop) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)stopLoop {
    //这里米有多线程问题，都是从self.thread执行的。
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.stoped = YES;
    self.thread = nil;
}


- (void)dealloc {
    if (!self.stoped) {
        [self performSelector:@selector(stopLoop) onThread:self.thread withObject:nil waitUntilDone:YES];
    }
}

@end
