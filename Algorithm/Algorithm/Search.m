//
//  Search.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/5.
//

#import "Search.h"


@interface Search()

@property (nonatomic, strong) NSArray<NSNumber *> *array;

@end



@implementation Search

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self setupBinarySearch];
        [self setupDelete];
        [self deleteValue:2];
    }
    return self;
}

- (void)setupDelete {
    self.array = @[@0,@1, @2, @3, @3,@0,@4,@2];
}

- (void)setupBinarySearch {
    self.array = @[@1, @2, @3, @4,@5,@6,@7,@8,@9,@10];
}

- (void)bianrySearch:(int)target {
//    我们定义 target 是在一个在左闭右闭的区间里，也就是[left, right] ,所以下面right=count-1
    NSUInteger left = 0;
    NSUInteger right = self.array.count-1;
//    while (left <= right) 要使用 <= ，因为left == right是有意义的
    while (left <= right) {
        NSUInteger mid = left + (right-left)/2; // 防止溢出 等同于(left + right)/2
        if (self.array[mid].intValue == target) {
            NSLog(@"在第%lu个", mid);
            return;
        } else if (self.array[mid].intValue > target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    NSLog(@"没找到");
    return;
}
NSUInteger slow = 0;
- (void)deleteValue:(NSUInteger)value {
    NSMutableArray<NSNumber *> *array = self.array.mutableCopy;
    for (NSUInteger fast = 0; fast < array.count; fast++) {
        if (array[fast].intValue != value) {
            array[slow] = array[fast];
            slow++;
        }
    }
    [array removeObjectsInRange:NSMakeRange(slow, self.array.count-slow)];
    self.array = array.copy;
    NSLog(@"result: %@", self.array);

}
@end
