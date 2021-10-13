//
//  List.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import "List.h"

@interface List ()

@property (nonatomic, strong) ListNode *node;
@property (nonatomic, assign) NSUInteger point;

@end

@implementation List

- (instancetype)initWithAray:(NSArray *)array
{
    self = [super init];
    if (self) {
        [self setupList:array];
    }
    return self;
}

- (instancetype)initWithAray:(NSArray *)array circlePoint:(NSUInteger)point
{
    self = [super init];
    if (self) {
        [self setupLinkList:array point:point];
        NSLog(@"链表：%@", array);
    }
    return self;
}

- (void)setupLinkList:(NSArray *)array point:(NSUInteger)point {
    if (array.count <= point) {
        return;
    }
    ListNode *node = [[ListNode alloc] init];
    __block ListNode *pointer = node;
    [array enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ListNode *tmp = [[ListNode alloc] init];
        tmp.value = obj.intValue;
        pointer.next = tmp;
        pointer = tmp;
    }];
    self.node = node.next;
    int k = (int)point;
    if (k >= 0) {
        while (k >= 0) {
            node = node.next;
            k--;
        }
        pointer.next = node;
        NSLog(@"环指向：%d", node.value);
    } else {
        NSLog(@"wu huan");
    }

}

- (void)setupList:(NSArray *)array {
    if (array.count == 0) {
        return;
    }
//    self.node
    ListNode *node = [[ListNode alloc] init];
    __block ListNode *pointer = node;
    [array enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ListNode *tmp = [[ListNode alloc] init];
        tmp.value = obj.intValue;
        pointer.next = tmp;
        pointer = tmp;
    }];
    self.node = node.next;
    [self outputLikeList];
}

- (void)outputLikeList {
    ListNode *node = self.node;
    while (node) {
        NSLog(@"%d", node.value);
        node = node.next;
    }
}

- (void)reverse {
    ListNode *node = self.node;
    ListNode *node2 = node.next;
    node.next = nil;
    ListNode *node3 = node2.next;
    while (node2) {
        node2.next = node;
        node = node2;
        node2 = node3;
        node3 = node2.next;
    }
    self.node = node;
    NSLog(@"reversed---------");
    [self outputLikeList];
}

- (void)checkCircle {
    ListNode *slow = self.node;
    ListNode *fast = self.node;
    while (slow && fast) {
        slow = slow.next;
        fast = fast.next.next;
        if (slow == fast) {
            NSLog(@"又环");
            slow = self.node;
            int k = 0;
            while (slow != fast) {
                slow = slow.next;
                fast = fast.next;
                k++;
            }
            NSLog(@"环入口在 %d", k);
            return;
        }
    }
    NSLog(@"没有环");
}

@end
