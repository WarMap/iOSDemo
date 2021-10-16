//
//  SearchRange.m
//  Algorithm
//
//  Created by mapeng on 2021/10/15.
//

#import "SearchRange.h"

@implementation SearchRange

NSArray *cArray2ocArray(int arr[], int size) {
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < size; ++i) {
        [result addObject:[NSNumber numberWithInt:arr[i]]];
    }
    return result.copy;
}

+(void)run {
//    int array[] = {5,7,7,8,8,10};
    int array[] = {};
    NSArray *result = [self searchRange:cArray2ocArray(array, 0) target:0];
    NSLog(@"index:%@, count:%@", result.firstObject, result.lastObject);
}

+ (NSArray *)searchRange:(NSArray<NSNumber *> *)nums target:(int)target {
    if (nums.count == 0 || target < nums.firstObject.intValue) {
        return @[@(-1), @(-1)];
    }
    NSUInteger front = 0;
    NSUInteger back = nums.count-1;
    while ((nums[front].unsignedIntValue != target || nums[back].unsignedIntValue != target) && back > front) {
        if (nums[front].unsignedIntValue < target) {
            front++;
        }
        if (nums[back].unsignedIntValue > target) {
            back--;
        }
    }
    if (front == back) {
        if (nums[front].unsignedIntValue == target) {
            return @[@(front), @1];
        } else {
            return @[@(-1), @(-1)];
        }
    }
    return @[@(front), @(back)];
}
@end
