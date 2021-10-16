//
//  MaxProfit.m
//  Algorithm
//
//  Created by mapeng on 2021/10/16.
//

#import "MaxProfit.h"

@implementation MaxProfit

+ (void)run {
//    int arr[] = {7,1,5,3,6,4};
//    int arr[] = {1,2,3,4,5};
    int arr[] = {7,6,4,3,1};
    
    NSInteger maxProfit = [self maxProfit:cArray2ocArray(arr, 5)];
    NSLog(@"max profit %lu", maxProfit);
}

+ (NSInteger)maxProfit:(NSArray<NSNumber *> *)prices {
    NSInteger profit = 0;
    for (int i = 0; i < prices.count-1; ++i) {
        if (IV(prices[i+1])>IV(prices[i])) {
            profit += IV(prices[i+1]) - IV(prices[i]);
        }
    }
    return profit;
}
@end
