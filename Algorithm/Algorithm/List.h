//
//  List.h
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface List : NSObject

- (instancetype)initWithAray:(NSArray *)array;
- (instancetype)initWithAray:(NSArray *)array circlePoint:(NSUInteger)point;
- (void)reverse;
- (void)checkCircle;

@end

NS_ASSUME_NONNULL_END
