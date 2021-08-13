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
#import "MPThreadUtil.h"

using namespace std;
#define KSVideoPreloadInfoLog(frmt, ...)   KSTLogAMInfo(frmt, ##__VA_ARGS__)
#define KS_VIDEO_PRELOAD_PAGE_STAY_TIME_LOG(frmt, ...) KSVideoPreloadInfoLog(@"[页面停留时长]", frmt, ##__VA_ARGS__)
#define KSMPLOG(frmt, ...) KSVideoPreloadInfoLog((@[@"war", @"map"]), frmt, ##__VA_ARGS__)
#define KSVideoPreloadMGRErrorLog(frmt, ...) KSVideoPreloadInfoLog(@"Manager", frmt, ##__VA_ARGS__)

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
    [self setupGes];
    NSLog(@"warmap " @"warmap " @"nihao%@",self);
    self.aPort = [NSMachPort port];
    self.aPort.delegate = self;
    [[NSRunLoop currentRunLoop] addPort:self.aPort forMode:NSRunLoopCommonModes];
    self.task = [[MPSomeTask alloc] initWithPort:self.aPort];
    [[NSThread currentThread] setName:@"mainThread"];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    KSVideoPreloadMGRErrorLog(@"注册数据源结束 dataSource为空");
//    KS_VIDEO_PRELOAD_PAGE_STAY_TIME_LOG(@"添加了一个次均播放时长 %@", @(3));
    KSVideoPreloadInfoLog(@"nihao");
    KSMPLOG(@"hhhhhhhh");
}
- (void)setupGes {
    UITapGestureRecognizer *tapGES = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerdidTapView:)];
    tapGES.numberOfTouchesRequired = 1;
    tapGES.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGES];
    UITapGestureRecognizer *tap2GES = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerdidTapView:)];
    tap2GES.numberOfTouchesRequired = 2;
    tap2GES.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap2GES];
    UITapGestureRecognizer *tapGES2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerdidTapViewTwo:)];
    tapGES2.numberOfTouchesRequired = 1;
    tapGES2.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGES2];
    
    [tapGES requireGestureRecognizerToFail:tap2GES];
    [tapGES requireGestureRecognizerToFail:tapGES2];
}

- (void)handleMachMessage:(void *)msg {
    currentThreadInfo(@"receive");
}

- (void)singleFingerdidTapView:(UITapGestureRecognizer *)ges {
    [self.task runPort];
}

- (void)doubleFingerdidTapView:(UITapGestureRecognizer *)ges {
    currentThreadInfo(@"fire   ");
    NSData *data1 = [@"warmap" dataUsingEncoding:NSUTF8StringEncoding];
    [self.task.port sendBeforeDate:[NSDate date] components:@[data1, self.aPort].mutableCopy from:self.aPort reserved:4];
}

- (void)singleFingerdidTapViewTwo:(UITapGestureRecognizer *)ges {
    [self.task killThread];
}

- (void)didTapView:(UITapGestureRecognizer *)ges {
    [MPGCDTest test];
    [MPOperationTest testOP];
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
