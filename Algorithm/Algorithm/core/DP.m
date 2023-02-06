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
@end
