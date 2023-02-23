//
//  Runloop.m
//  Runloop
//
//  Created by 马鹏 on 2023/2/23.
//

#import "Runloop.h"

@implementation Runloop

+ (void)test {
    // dispatch async main queue一个loop可注册进去多个。
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dispatch async main queue 1");
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dispatch async main queue 2");
    });
}
@end
