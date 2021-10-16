//
//  ListNode.m
//  Algorithm
//
//  Created by mapeng on 2021/10/13.
//

#import "ListNode.h"

@implementation ListNode

- (instancetype)initWithValue:(int)value next:(ListNode * _Nullable)node {
    self = [super init];
    if (self) {
        self.value = value;
        self.next = node;
    }
    return self;
}

- (instancetype)initWithArray:(NSArray<NSNumber *> *)array {
    self = [super init];
    if (self && array.count > 0) {
        self.value = array.firstObject.intValue;
        NSMutableArray *tmp = [NSMutableArray arrayWithArray:array];
        [tmp removeObjectAtIndex:0];
        self.next = [[ListNode alloc] initWithArray:tmp.copy];
    } else {
        return nil;
    }
    return self;
}

- (void)output {
    ListNode *tem = self;
    int i = 1;
    while (tem) {
        NSLog(@"第%d节点 - %d",i, tem.value);
        tem = tem.next;
    }
}
@end
