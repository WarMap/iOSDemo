//
//  ViewController.m
//  Thread
//
//  Created by 马鹏 on 2021/7/26.
//

#import "ViewController.h"
#import "Star.h"
#import "MPGCDTest.h"
#import "MPOperationTest.h"
#include <iostream>
#import <Foundation/NSPort.h>
#import <objc/runtime.h>
#import "MPSomeTask.h"
#include <pthread.h>
#include <mach/mach.h>

using namespace std;

@interface ViewController ()<NSPortDelegate>

@property (nonatomic, weak) NSObject *obj;
@property (nonatomic, weak) Star *star;

@property (nonatomic, strong) NSPort *aPort;
@property (nonatomic, strong) NSPort *bPort;
@property (nonatomic, strong) MPSomeTask *task;
@end

// 线程，基本运行单元
// 进程  操作系统分配资源的基本单位


//线程生命周期
//新建，就绪，运行，阻塞，死亡
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aPort = [NSMachPort port];
    self.aPort.delegate = self;
    [[NSRunLoop currentRunLoop] addPort:self.aPort forMode:NSRunLoopCommonModes];
    self.task = [[MPSomeTask alloc] initWithPort:self.aPort];
    [[NSThread currentThread] setName:@"mainThread"];
    // Do any additional setup after loading the view.
}

- (void)handleMachMessage:(void *)msg {
    NSLog(@"mainThread callback---");
    NSThread* thread = [NSThread currentThread];
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    NSLog(@"current thread num: %x thread name:%@", machTID,thread.name);
    NSLog(@"---------------------");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self gcdTest];
    [MPGCDTest test];
    [MPOperationTest testOP];
    if (event.allTouches.count == 1) {
        [self.task runPort];
    } else if (event.allTouches.count == 2) {
        NSData *data1 = [@"warmap" dataUsingEncoding:NSUTF8StringEncoding];
        [self.task.port sendBeforeDate:[NSDate date] components:@[data1, self.aPort].mutableCopy from:self.aPort reserved:4];
    } else if (event.allTouches.count == 3) {
        [self.task killThread];
    }
//    dumpThreads();
//    tossss();
}

static inline void dumpThreads() {
    
    NSLog(@"-------------------");
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

void tossss() {
    int a = 2;
    string b = to_string(a);
    cout << b;
}


- (void)gcdTest {

    [self performSelector:@selector(test2)];
    [self performSelector:@selector(test3) withObject:nil afterDelay:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"5");
        Star *obj = [Star new];
        self.star = obj;
        NSLog(@"5--%@", self.obj);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"4");
        NSLog(@"4--%@", self.obj);
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"6");
    });
    [self test1];
}

- (void)test1 {
    NSLog(@"1");
}
- (void)test2 {
    NSLog(@"2");
}
- (void)test3 {
    NSLog(@"3");
    NSLog(@"3--%@", self.obj);
}
@end
