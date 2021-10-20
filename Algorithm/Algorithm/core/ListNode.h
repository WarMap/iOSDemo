//
//  ListNode.h
//  Algorithm
//
//  Created by mapeng on 2021/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListNode : NSObject

@property (nonatomic, strong) ListNode * __nullable next;
@property (nonatomic, assign) int value;

- (instancetype)initWithValue:(int)value next:(ListNode * _Nullable)node;
- (instancetype)initWithArray:(NSArray<NSNumber *> *)array;
+ (instancetype)listWithArray:(NSArray<NSNumber *> *)array;

- (void)output;
@end

NS_ASSUME_NONNULL_END
