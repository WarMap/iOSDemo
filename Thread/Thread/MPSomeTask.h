//
//  MPSomeTask.h
//  Thread
//
//  Created by 马鹏 on 2021/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPSomeTask : NSObject

@property (nonatomic, strong) NSPort *port;

- (instancetype)initWithPort:(NSPort *)port;
- (void)runPort;
- (void)killThread;

@end

NS_ASSUME_NONNULL_END
