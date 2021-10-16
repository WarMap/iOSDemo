//
//  TreeSum.m
//  Algorithm
//
//  Created by mapeng on 2021/10/15.
//

#import "TreeSum.h"

@implementation TreeSum

+ (void)run {
    int arr[] = {0};// {-1, 0, 1, 2, -1, -4};
    NSArray *array = cArray2ocArray(arr, 1);
    [self threeSum:array];
}

+ (NSArray<NSArray *> *)threeSum:(NSArray<NSNumber *> *)nums {
    //先排序。  nlogn
    nums = [nums sortedArrayUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber *  _Nonnull obj2) {
        if (obj1.intValue > obj2.intValue) {
            return NSOrderedDescending;
        } else if (obj1.intValue == obj2.intValue) {
            return NSOrderedSame;
        } else {
            return NSOrderedAscending;
        }
    }];
    NSNumber *last = @(INT_MIN);
    NSMutableArray<NSMutableArray<NSNumber *> *> *result = [NSMutableArray array];
    for (int i = 0; i < nums.count; ++i) {
        //相同的值可跳过
        if (nums[i].intValue != last.intValue) {
            //range处理好，i+1，count-i-1
            NSArray<NSMutableArray<NSNumber *> *> *twoSum = [self twoSum:[nums subarrayWithRange:NSMakeRange(i+1, (nums.count-i-1))] target:nums[i].intValue];
            for (NSMutableArray *subArr in twoSum) {
                [subArr insertObject:nums[i] atIndex:0];
                [result addObject:subArr];
            }
            last = nums[i];
        }
    }
    return result;
}

+ (NSArray<NSMutableArray<NSNumber *> *> *)twoSum:(NSArray<NSNumber *> *)nums target:(int)target {
    if (nums.count < 2) {
        return nil;
    }
    int front = 0;
    NSUInteger back = nums.count-1;
    NSMutableArray *result = [NSMutableArray array];
    int lastFront = -1;
    //双指针，front《 back即可。记录上一个值，相同则无须比较
    while (front < back) {
        if (lastFront >= 0 && nums[front].intValue == nums[lastFront].intValue) {
            lastFront = front;
            front++;
        } else {
            if (nums[front].intValue + nums[back].intValue + target == 0) {
                [result addObject:[NSMutableArray arrayWithArray:@[nums[front], nums[back]]]];
                lastFront = front;
                front++;
                back--;
            } else if (nums[front].intValue + nums[back].intValue + target > 0) {
                back--;
            } else {
                lastFront = front;
                front++;
            }
        }
    }
    return result;
}
@end
