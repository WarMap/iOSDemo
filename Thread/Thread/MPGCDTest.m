//
//  MPGCDTest.m
//  Thread
//
//  Created by 马鹏 on 2021/8/4.
//

#import "MPGCDTest.h"

@implementation MPGCDTest


+ (void)test {
//    [self deadlock];
}

//互斥条件：一个资源每次只能被一个线程使用。
//请求与保持条件：一个线程因请求资源而阻塞时，对已获得的资源保持不放。
//不剥夺条件：线程已获得的资源，在末使用完之前，不能强行剥夺。
//循环等待条件：若干线程之间形成一种头尾相接的循环等待资源关系。
+ (void)deadlock {
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("warmap", NULL);
    NSLog(@"1");
    
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}


- (void)queue {
    dispatch_queue_t conQueue = dispatch_queue_create("warmap.concurent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serQueue = dispatch_queue_create("warmap.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}


@end
