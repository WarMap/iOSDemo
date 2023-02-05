//
//  MaxSubarray.m
//  Algorithm
//
//  Created by 马鹏 on 2023/2/4.
//

#import "MaxSubarray.h"

//https://leetcode.cn/problems/maximum-subarray/
@implementation MaxSubarray
+ (void)run {
    int a[] = {-2,1,-3,4,-1,2,1,-5,4};
    [self maxSubarray:cArray2ocArray(a, 9)] ;
}

+ (NSArray *)maxSubarray:(NSArray *)array {
    return nil;
}


@end
