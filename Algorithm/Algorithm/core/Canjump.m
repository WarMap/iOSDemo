//
//  Canjump.m
//  Algorithm
//
//  Created by mapeng on 2021/10/16.
//

#import "Canjump.h"

@implementation Canjump

+ (void)run {
//    int arr[] = {2,3,1,1,4};
    int arr[] = {3,2,1,0,4};
    BOOL flag = [self canJump:cArray2ocArray(arr, 5)];
    NSLog(@"%@ jump to end", flag?@"can":@"can't");
}

//注意i<=rightmost
+ (BOOL)canJump:(NSArray<NSNumber *> *)nums {
    NSInteger rightMost = 0;
    for (NSUInteger i = 0; i < nums.count; ++i) {
        if (i<=rightMost) {
            rightMost = MAX(rightMost, i+IV(nums[i]));
            if (rightMost >= nums.count-1) {
                return true;
            }
        }
    }
    return false;
}
@end
