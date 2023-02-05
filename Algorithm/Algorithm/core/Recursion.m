//
//  Recursion.m
//  Algorithm
//
//  Created by 马鹏 on 2023/2/5.
//

#import "Recursion.h"

@implementation Recursion

+ (void)run {
//    1,1,2,3,5,8
    NSLog(@"fibo 6 = %d", [self fibo:6]);
    NSLog(@"recur add 1-100 = %d", [self recurAdd:100]);
    NSLog(@"2^10 = %d", [self pow:2 n:10]);
}

+ (int)fibo:(int)n {
    if (n == 0 || n == 1) {
        return n;
    }
    return [self fibo:n-1] + [self fibo:n-2];
}


+ (int)recurAdd:(int)num {
    if (num == 1) {
        return 1;
    } else {
        return [self recurAdd:num-1]+num;
    }
}

+ (int)pow:(int)x n:(int)n {
    if (n == 0) {
        return 1;
    }
    if (n < 0) {
        return 1/[self pow:x n:-n];
    }
    if (n % 2) {
        return x * [self pow:x n:n-1];
    }
    return [self pow:x*x n:n/2];
}

@end
