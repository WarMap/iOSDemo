//
//  DP.m
//  Algorithm
//
//  Created by 马鹏 on 2023/2/6.
//

#import "DP.h"

@implementation DP

+ (void)run {
    [self testclimbStairs];
    [self testMiniTotal];
}
//https://leetcode.cn/problems/climbing-stairs/
+ (void)testclimbStairs {
    NSLog(@"climb 3 stairs %d", [self climbStairs:3]);
}

+ (int)climbStairs:(int)n {
    int dp[n+1];
    dp[0]=1;
    dp[1]=1;
    for (int i=2; i<=n; ++i) {
        dp[i] = dp[i-1] + dp[i-2];
    }
    return dp[n];
}

+ (void)testMiniTotal {
    NSArray *triangle = @[@[@2],@[@3,@4],@[@6,@5,@7],@[@4,@1,@8,@3]];
    int i = [self miniTotal:triangle];
    NSLog(@"mini path = %d", i);
}

+ (int)miniTotal:(NSArray <NSArray <NSNumber *>*>*)triangle {
    NSMutableArray <NSNumber *>*mini = [NSMutableArray arrayWithArray:triangle.lastObject] ;
    for (int i=triangle.count-2; i>=0; --i) {
        for (int j = 0; j<triangle[i].count; ++j) {
            mini[j] = @(triangle[i][j].intValue + MIN(mini[j].intValue, mini[j+1].intValue));
        }
    }
    return mini[0].intValue;
}

@end
