//
//  Math.m
//  Algorithm
//
//  Created by 马鹏 on 2024/4/28.
//

#import "Math.h"

@implementation Math

+ (void)run
{
    [self reverseIntTest];
}

// 7题
+ (void)reverseIntTest
{
    ;
    NSLog(@"INT_MAX = %d", [self reverseInt:123]);
    NSLog(@"INT_MAX = %d", [self reverseInt:1147483649]);
    NSLog(@"INT_MAX = %d", [self reverseInt:-2147483412]);
//    NSLog(@"INT_MAX = %d", [self reverseInt:123]);

}

+ (int)reverseInt:(int)x
{
    int res = 0;
    while (x != 0) {
        if (res > INT_MAX/10 || res < INT_MIN/10) return 0;
        int dig = x%10;
        x /= 10;
        res = res*10+dig;
    }
    
    return res;
}
@end
