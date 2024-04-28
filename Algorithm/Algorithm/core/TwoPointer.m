//
//  TwoPointer.m
//  Algorithm
//
//  Created by 马鹏 on 2024/4/28.
//

#import "TwoPointer.h"

@implementation TwoPointer

+ (void)run
{
    [self maxAreaTest];
}

+ (void)maxAreaTest
{
    NSArray<NSNumber *> *heights = @[@1, @8, @6, @2, @5, @4, @8, @3, @7];
    NSInteger maxArea = [self maxArea:heights];
    NSLog(@"The maximum area is: %ld", maxArea); // 输出最大面积

}

+ (NSInteger)maxArea:(NSArray<NSNumber *> *)height {
    NSInteger maxarea = 0, l = 0;
    NSInteger r = [height count] - 1;
    
    while (l < r) {
        // 计算当前指针对应的容积
        maxarea = MAX(maxarea, MIN(height[l].integerValue, height[r].integerValue) * (r - l));
        // 根据哪边的高度小，来移动对应的指针
        if (height[l].integerValue < height[r].integerValue) {
            l++;
        } else {
            r--;
        }
    }
    
    return maxarea;
}

@end
