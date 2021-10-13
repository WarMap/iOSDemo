//
//  LRU.h
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRU : NSObject

- (instancetype)initWithArray:(NSArray *)array count:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
