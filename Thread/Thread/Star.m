//
//  Star.m
//  Thread
//
//  Created by 马鹏 on 2021/7/26.
//

#import "Star.h"

@implementation Star

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (void)dealloc
{
    NSLog(@"deallocing");
}

- (void)kst_log:(KSTLogLevel)level
         module:(NSString *)module
           tags:(NSArray<NSString *> *)tags
           file:(const char *)file
       function:(nullable const char *)function
           line:(NSUInteger)line
         format:(NSString *)format, ...  {
    
}
@end
