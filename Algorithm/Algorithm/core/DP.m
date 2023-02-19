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
    [self testMinPath];
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
//https://leetcode.cn/problems/minimum-path-sum/
+ (void)testMinPath {
    NSArray *array = @[@[@1,@3,@1].mutableCopy,
                       @[@1,@5,@1],
                       @[@4,@2,@1]
    ];
    int res = [self minPath:array];
    NSLog(@"mini path count = %d", res);
}

+ (int)minPath:(NSArray <NSArray <NSNumber *>*>*)path {
    int row = path.count;
    int col = path.firstObject.count;
    NSMutableArray <NSMutableArray <NSNumber *>*>*dp = [NSMutableArray array];
    for (NSArray *row in path) {
        [dp addObject:row.mutableCopy];
    }
    for (int i = row-1; i>=0; --i) {
        for (int j = col-1; j>=0; --j) {
            if (i == row-1 && j == col-1) {
                dp[i][j] = path[i][j];
            } else if (i == row-1) {
                dp[i][j] = @(IV(path[i][j])+IV(dp[i][j+1]));
            } else if (j == col-1) {
                dp[i][j] = @(IV(path[i][j])+IV(dp[i+1][j]));
            } else {
                dp[i][j] = @(IV(path[i][j])+MIN(IV(dp[i+1][j]), IV(dp[i][j+1])));
            }
        }
    }
    return IV(dp[0][0]);
}

@end
