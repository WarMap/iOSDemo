//
//  Search.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/5.
//

#import "Search.h"

@implementation Search
+ (void)run {
    int ar[] = {1,2,3,4,5,6,7,8,9,10};
//    [self bianrySearch:cArray2ocArray(ar, 10) target:3];
    NSArray *result = [self deleteValue:3 inNums:cArray2ocArray(ar, 10)];
    NSLog(@"删除后： %@", result);
}

+ (void)bianrySearch:(NSArray<NSNumber *> *)nums target:(int)target {
//    我们定义 target 是在一个在左闭右闭的区间里，也就是[left, right] ,所以下面right=count-1
    NSUInteger left = 0;
    NSUInteger right = nums.count-1;
//    while (left <= right) 要使用 <= ，因为left == right是有意义的
    while (left <= right) {
        NSUInteger mid = left + (right-left)/2; // 防止溢出 等同于(left + right)/2
        if (nums[mid].intValue == target) {
            NSLog(@"在第%lu个", mid);
            return;
        } else if (nums[mid].intValue > target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    NSLog(@"没找到");
    return;
}
+ (NSArray<NSNumber *> *)deleteValue:(NSUInteger)value inNums:(NSArray<NSNumber *> *)nums {
    NSMutableArray<NSNumber *> *array =nums.mutableCopy;
    NSUInteger slow = 0;
    for (NSUInteger fast = 0; fast < array.count; fast++) {
        if (array[fast].intValue != value) {
            array[slow] = array[fast];
            slow++;
        }
    }
    [array removeObjectsInRange:NSMakeRange(slow, nums.count-slow)];
    return array;
}
@end
