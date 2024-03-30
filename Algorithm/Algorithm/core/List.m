//
//  List.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import "List.h"

@implementation List

+ (void)run {
//    [self reverseTest];
    [self checkCircle];
//    [self testMergeTwoList];
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
//https://leetcode.cn/problems/reverse-linked-list/
+ (ListNode *)reverse:(ListNode *)head {
    ListNode *dummy = [ListNode nodeWithValue:0 next:head];
    ListNode *c = head;
    ListNode *next = nil;
    while (c.next) {
        next = c.next;
        c.next = next.next;
        next.next = dummy.next;
        dummy.next = next;
    }
    return dummy.next;
}

//https://leetcode.cn/problems/reverse-linked-list-ii/
+ (ListNode *)reverse:(ListNode *)head begin:(NSUInteger)begin end:(NSUInteger)end {
    ListNode *dummy = [ListNode nodeWithValue:0 next:head];
    ListNode *pre = dummy;
    for (int step = 0; step < begin-1; ++step) {
        pre = pre.next;
    }
    ListNode *cur = pre.next;
    ListNode *next = nil;
    NSUInteger count = end-begin;
    NSUInteger i = 0;
    while (i < count) {
        next = cur.next;
        cur.next = next.next;
        next.next = pre.next;
        pre.next = next;
        ++i;
    }
    return dummy.next;
}
//https://leetcode.cn/problems/linked-list-cycle-ii/
+ (void)checkCircleTest:(ListNode *)node {
    ListNode *slow = node;
    ListNode *fast = node;
    while (slow && fast) {
        slow = slow.next;
        fast = fast.next.next;
        if (slow == fast) {
            NSLog(@"有环");
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
//https://leetcode.cn/problems/merge-two-sorted-lists/
+ (void)testMergeTwoList {
    int a[] = {1,2,4};
    int b[] = {1,3,4};
    ListNode *l1 = [ListNode listWithArray:cArray2ocArray(a, 3)];
    ListNode *l2 = [ListNode listWithArray:cArray2ocArray(b, 3)];
    ListNode *res = [self mergeTwoList:l1 list2:l2];
    [res output];
}

+ (ListNode *)mergeTwoList:(ListNode *)list1 list2:(ListNode*)list2 {
    if (!list1) return list2;
    if (!list2) return list1;
    if (list1.value <= list2.value) {
         list1.next = [self mergeTwoList:list1.next list2:list2];
        return list1;
    } else {
        list2.next = [self mergeTwoList:list1 list2:list2.next];
        return list2;
    }
}

@end
