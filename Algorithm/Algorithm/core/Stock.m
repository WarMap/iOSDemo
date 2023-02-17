//
//  Stock.m
//  Algorithm
//
//  Created by 马鹏 on 2023/2/14.
//

#import "Stock.h"

@interface Stock ()
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation Stock

+ (void)run {
    Stock *stock = [Stock alloc];
    stock.dic = [NSMutableDictionary dictionary];
    int fib = [stock fib:6];

    [[[Stock alloc] init] maxProfit];
    [self testMaxProfit1];
}
//https://leetcode.cn/problems/best-time-to-buy-and-sell-stock/
- (void)maxProfit {
   int profit = [self maxProfit:@[@7,@1,@5,@3,@6,@4]];
    NSLog(@"max profit = %d", profit);
}

- (int)maxProfit:(NSArray <NSNumber *>*)prices {
    int profit = 0;
    for (NSUInteger i = 1; i<prices.count; ++i) {
        int tmp = prices[i].intValue - prices[i-1].intValue;
        if (tmp > 0) {
            profit += tmp;
        }
    }
    return profit;
}

//https://leetcode.cn/problems/gu-piao-de-zui-da-li-run-lcof/
+ (void)testMaxProfit1 {
    int a[] = {7,1,5,3,6,4};
    int res = [self maxProfit1:cArray2ocArray(a, 6)];
    NSLog(@"max profit 1 = %d", res);
}

+ (int)maxProfit1:(NSArray <NSNumber *>*)prices {
    int minPrice = INT_MAX;
    int maxPrice = 0;
    for (int i = 0; i<prices.count; ++i) {
        if (IV(prices[i]) < minPrice) {
            minPrice = IV(prices[i]);
        } else if (maxPrice < IV(prices[i]) - minPrice) {
            maxPrice = IV(prices[i]) - minPrice;
        }
    }
    return maxPrice;
}
- (int)fib:(int)n {
    if (n == 0) {
        self.dic[@0] = @0;
        return 0;
    } else if (n == 1) {
        self.dic[@1] = @1;
        return 1;
    } else if (self.dic[@(n)]) {
        NSNumber *tmp = (NSNumber *)self.dic[@(n)];
        return tmp.intValue;
    } else {
        int tmp = [self fib:(n-1)] + [self fib:(n-2)];
        self.dic[@(n)] = @(tmp);
        return tmp;
    }
}

//- (int)countPath:(NSArray *)grid row:(int)row col:(int)col {
//    
//}


@end
