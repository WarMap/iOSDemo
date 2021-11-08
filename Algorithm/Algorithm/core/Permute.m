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
NSMutableArray *result;

+ (NSMutableArray *)Permute:(NSMutableArray<NSNumber *> *)nums {
//    NSMutableArray<NSArray<NSNumber *> *> *result = [NSMutableArray array];
    result = [NSMutableArray array];
    [self backTrack:nums temp:[NSMutableArray array]];
    NSLog(@"result");
//    [self backTrack:result nums:nums first:0];
    return result;
}

//回溯法
//1. 终止条件
//2. 路径
//3. 可选节点
//4. 存储的容器，注意指针类型重复使用

+ (void)backTrack:(NSMutableArray<NSNumber *> *)nums
             temp:(NSMutableArray<NSNumber *> *)temp {
    if (nums.count == 1) {
        //移除添加注意要成对
        [temp addObject:nums.firstObject];
        [result addObject:temp.copy]; //这里注意copy，不然会被其他回溯改变值
        [temp removeObject:nums.firstObject];
        return;
    }
    for (int i = 0; i < nums.count; ++i) {
        //移除添加注意要成对
        [temp addObject:nums[i]];
        NSMutableArray *array = nums.mutableCopy;
        [array removeObjectAtIndex:i];
        [self backTrack:array temp:temp];
        [temp removeObject:nums[i]];
    }
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
