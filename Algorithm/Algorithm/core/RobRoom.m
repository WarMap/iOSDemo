//
//  RobRoom.m
//  Algorithm
//
//  Created by 马鹏 on 2021/10/14.
//

#import "RobRoom.h"

@implementation RobRoom

+ (void)run {
    int result = [self robTheGreatestValue:@[@2, @7, @9, @3, @1]];
    NSLog(@"greatest rob value is: %d", result);
}

+ (int)robTheGreatestValue:(NSArray<NSNumber *> *)nums {
    if (nums.count == 0) {
        return 0;
    }
    int back = nums.firstObject.intValue;
    if (nums.count == 1) {
        return back;
    } else if (nums.count == 2) {
        return MAX(back, nums[1].intValue);
    }
    int front = nums[1].intValue;
    for (int i = 2; i<nums.count; ++i) {
        int temp = MAX(back+nums[i].intValue, front);
        back = front;
        front = temp;
    }
    return front;
}
@end
