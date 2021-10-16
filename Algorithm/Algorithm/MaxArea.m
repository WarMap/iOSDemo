//
//  MaxArea.m
//  Algorithm
//
//  Created by mapeng on 2021/10/16.
//

#import "MaxArea.h"



@implementation MaxArea

+ (void)run {
//    int n[] = {1,8,6,2,5,4,8,3,7};
//    int n[] = {1,1};
//    int n[] = {4,3,2,1,4};
    int n[] = {1,2,1};
    [self maxArea:cArray2ocArray(n, 3)];
}
// 1.双指针。2.较小的移动。3.相同时下一个较大的移动
+ (void)maxArea:(NSArray<NSNumber *> *)height {
    NSUInteger front = 0;
    NSUInteger back = height.count-1;
    NSUInteger maxArea = 0;
    while (front < back) {
        NSUInteger width = back - front;
        NSUInteger curHeight = MIN(IV(height[front]), IV(height[back]));
        NSUInteger area = width * curHeight;
        if (maxArea < area) {
            maxArea = area;
        }
        if (IV(height[front]) > IV(height[back])) {
            back--;
        } else if (IV(height[front]) < IV(height[back])) {
            front++;
        } else {
            if (IV(height[front+1]) > IV(height[back-1])) {
                front++;
            } else {
                back--;
            }
        }
    }
    NSLog(@"max area:%lu", (unsigned long)maxArea);
}

@end
