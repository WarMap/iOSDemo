//
//  List.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import "List.h"

@implementation List

+ (void)run {
    [self reverseTest];
    [self checkCircle];
}

+ (void)checkCircle {
        int a[] = {1,2,3,4,5,6,7};
    ListNode *node = [[ListNode alloc] initWithArray:cArray2ocArray(a, 7)];
    [self setupLink:node circle:3 count:7];
    [self checkCircleTest:node];
}

+ (void)setupLink:(ListNode *)head
           circle:(NSUInteger)circle
            count:(NSUInteger)count {
    ListNode *dummy = [[ListNode alloc] initWithValue:0 next:head];
    ListNode *circlePoint = nil;
    for (int step = 0; step < count; ++step) {
        dummy = dummy.next;
        if (step == (circle-1)) {
            circlePoint = dummy;
        }
    }
    dummy.next = circlePoint;
}

+ (void)reverseTest {
    int a[] = {1,2,3,4,5};
//    ListNode *node = [self reverse:[[ListNode alloc] initWithArray:cArray2ocArray(a, 5)]];
    ListNode *node = [self reverse:[[ListNode alloc] initWithArray:cArray2ocArray(a, 5)] begin:2 end:3];
    [node output];
}

+ (ListNode *)reverse:(ListNode *)head {
    ListNode *node = head;
    ListNode *node2 = node.next;
    node.next = nil;
    ListNode *node3 = node2.next;
    while (node2) {
        node2.next = node;
        node = node2;
        node2 = node3;
        node3 = node2.next;
    }
    return node;
}

+ (ListNode *)reverse:(ListNode *)head begin:(NSUInteger)begin end:(NSUInteger)end {
    ListNode *dummy = [[ListNode alloc] initWithValue:0 next:head];
    ListNode *g = dummy;
    
    //移动到指定位置
    for (int step = 0; step < begin-1; ++step) {
        g = g.next;
    }
    ListNode *p = g.next;
    NSUInteger count = end - begin;
    for (int i = 0; i < count; ++i) {
        ListNode *removed = p.next;
        p.next = removed.next;
        removed.next = g.next;
        g.next = removed;
    }
    return head;
}

+ (void)checkCircleTest:(ListNode *)node {
    ListNode *slow = node;
    ListNode *fast = node;
    while (slow && fast) {
        slow = slow.next;
        fast = fast.next.next;
        if (slow == fast) {
            NSLog(@"又环");
            slow = node;
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
