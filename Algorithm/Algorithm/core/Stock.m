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

+ (void)testMaxProfit2 {
    
}
//+ (int)testMaxProfit2:(NSArray <NSNumber *>*)prices k:(int)k {
//    if (prices.count == 0) {
//        return 0;
//    }
//    int n = prices.count;
//    k = MIN(k, n/2);
//    NSMutableArray <NSMutableArray <NSNumber *>*>* buy = [NSMutableArray array];
//    NSMutableArray <NSMutableArray <NSNumber *>*>* sell = [NSMutableArray array];
//
//
// buy[0][0] = -prices[0];
// sell[0][0] = 0;
// for (int i = 1; i <= k; ++i) {
//     buy[0][i] = sell[0][i] = INT_MIN / 2;
// }
//
// for (int i = 1; i < n; ++i) {
//     buy[i][0] = max(buy[i - 1][0], sell[i - 1][0] - prices[i]);
//     for (int j = 1; j <= k; ++j) {
//         buy[i][j] = max(buy[i - 1][j], sell[i - 1][j] - prices[i]);
//         sell[i][j] = max(sell[i - 1][j], buy[i - 1][j - 1] + prices[i]);
//     }
// }
//
// return *max_element(sell[n - 1].begin(), sell[n - 1].end());
//}

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
