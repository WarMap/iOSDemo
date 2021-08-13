//
//  MPThread.h
//  Thread
//
//  Created by 马鹏 on 2021/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPThread : NSObject

@property (nonatomic, copy) NSString *name;
- (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(nullable id)argument;
- (void)performTask:(dispatch_block_t)task;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
