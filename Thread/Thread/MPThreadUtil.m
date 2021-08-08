//
//  MPThreadUtil.m
//  Thread
//
//  Created by 马鹏 on 2021/8/8.
//

#import "MPThreadUtil.h"
#include <pthread.h>
#include <mach/mach.h>



inline void dumpThreads() {
    NSLog(@"dumpThreads----------------------------------begin");
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
    NSLog(@"dumpThreads----------------------------------end..");
}

inline void currentThreadInfo(NSString *str) {
    NSThread* thread = [NSThread currentThread];
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    
    NSLog(@"%@ thread num: %x thread name:%@",str, machTID, thread.name);
}

@implementation MPThreadUtil

@end


