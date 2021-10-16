//
//  Permute.m
//  Algorithm
//
//  Created by mapeng on 2021/10/16.
//

#import "Permute.h"

@implementation Permute


+ (void)run {
    int nums[] = {1,2,3};
    NSArray *result = [self Permute:cArray2ocArray(nums, 3).mutableCopy];
    NSLog(@"permute: %@", result);
}

+ (NSMutableArray *)Permute:(NSMutableArray<NSNumber *> *)nums {
    NSMutableArray<NSArray<NSNumber *> *> *result = [NSMutableArray array];
    [self backTrack:result nums:nums first:0];
    return result;
}

//注意添加时候的mutablecopy！
+ (void)backTrack:(NSMutableArray<NSArray<NSNumber *> *> *)res
             nums:(NSMutableArray<NSNumber *> *)nums
            first:(NSUInteger)first {
    if (first == (nums.count-1)) {
        [res addObject:nums.mutableCopy];
        return;
    }
    for (NSUInteger i = first; i < nums.count; ++i) {
        [nums exchangeObjectAtIndex:first withObjectAtIndex:i];
        [self backTrack:res nums:nums first:first+1];
        [nums exchangeObjectAtIndex:first withObjectAtIndex:i];
    }
}
@end
