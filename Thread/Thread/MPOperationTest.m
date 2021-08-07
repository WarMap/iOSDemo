//
//  MPOperationTest.m
//  Thread
//
//  Created by 马鹏 on 2021/8/6.
//

#import "MPOperationTest.h"
#include <pthread.h>
#include <mach/mach.h>

static inline void currentThreadInfo(NSString* str)
{
    if (str)
        NSLog(@"---------%@----------",str);

    NSThread* thread = [NSThread currentThread];
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    NSLog(@"current thread num: %x thread name:%@", machTID,thread.name);
    
    if (str)
        NSLog(@"-------------------");
}


static inline void dumpThreads(NSString* str) {
    
    NSLog(@"---------%@----------",str);
    currentThreadInfo(nil);
    char name[256];
    thread_act_array_t threads = NULL;
    mach_msg_type_number_t thread_count = 0;
    task_threads(mach_task_self(), &threads, &thread_count);
    for (mach_msg_type_number_t i = 0; i < thread_count; i++) {
        thread_t thread = threads[i];
        pthread_t pthread = pthread_from_mach_thread_np(thread);
        pthread_getname_np(pthread, name, sizeof name);
        // 打印当前所有线程
        NSLog(@"mach thread %x: getname: %s", pthread_mach_thread_np(pthread), name);
    }
    NSLog(@"-------------------");
}

@interface MPOperation : NSOperation
{
    NSString*   _threadName;
    NSString*   _url;
    BOOL        executing;
    BOOL        finished;
}

@end

@implementation MPOperation

- (id)initWithUrl:(NSString*)url name:(NSString*)name {
    self = [super init];
    if (self) {
        if (name!=nil)
        _threadName = name;
        _url = url;
        executing = NO;
        finished = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start
{
    [NSThread currentThread].name = _threadName;
    currentThreadInfo(@"start");
    
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }

    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];

    executing = YES;
    
    //下载图片
    [NSData dataWithContentsOfURL:[NSURL URLWithString:_url]];
    
    //完成下载
    [self completeOperation];

    [self didChangeValueForKey:@"isExecuting"];
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)dealloc
{
    dumpThreads(@"dealloc");
}

@end


@implementation MPOperationTest
{
    NSOperationQueue *_queue;
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



+ (void)testOP {
    MPOperationTest *test = [self sharedInstance];
//    [test testOP];
}

- (void)testOP {
    NSArray* urls = @[@"https://reqres.in/img/faces/7-image.jpg",
                      @"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",@"https://reqres.in/img/faces/8-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",
                      @"https://reqres.in/img/faces/7-image.jpg",
    ];
    _queue = [NSOperationQueue new];
    _queue.maxConcurrentOperationCount =  3;
    for (int i=0; i<urls.count; i++)
    {
        MPOperation* operation = [[MPOperation alloc] initWithUrl:urls[i] name:[NSString stringWithFormat:@"%d",i]];
        [_queue addOperation:operation];
    }
    
}
@end
