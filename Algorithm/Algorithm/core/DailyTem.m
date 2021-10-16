//
//  DailyTem.m
//  Algorithm
//
//  Created by mapeng on 2021/10/16.
//

#import "DailyTem.h"

@implementation DailyTem

+ (void)run {
//    int arr[] = {73,74,75,71,69,72,76,73};
    int arr[] = {30,40,50,60};
    NSArray *result = [self dailyTem:cArray2ocArray(arr, 4)];
    NSLog(@"output :%@", result);
}

+ (NSArray<NSNumber *> *)dailyTem:(NSArray<NSNumber *> *)tem {
    NSMutableArray *result = [NSMutableArray array];
    for (NSNumber *nu in tem) {
        [result addObject:@0];
    }
    NSMutableArray<NSNumber *> *stack = [NSMutableArray array];
    for (int i = 0; i < tem.count; ++i) {
        while (stack.count != 0 && IV(tem[i]) > IV(tem[IV(stack.lastObject)])) {
            int t = IV(stack.lastObject);
            [stack removeLastObject];
            result[t] = @(i-t);
        }
        [stack addObject:@(i)];
    }
    return result;
}
@end
