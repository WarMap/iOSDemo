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
        [self setup];
    }
    return self;
}

- (void)setup {
    self.array = @[@1, @2, @3, @4,@5,@6,@7,@8,@9,@10];
}

- (void)bianrySearch:(int)target {
    NSUInteger left = 0;
    NSUInteger right = self.array.count-1;
    while (left <= right) {
        NSUInteger mid = left + (right-left)/2;
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

@end
