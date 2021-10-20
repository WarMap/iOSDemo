//
//  RotateRight.m
//  Algorithm
//
//  Created by 马鹏 on 2021/10/18.
//

#import "RotateRight.h"

@implementation RotateRight

+ (void)run {
    int a[] = {1, 2, 3,4,5};
    ListNode *head = [[ListNode alloc] initWithArray:cArray2ocArray(a, 5)];
    ListNode *result = [self rotateRight:head k:2];
    NSLog(@"rotate right :");
    [result output];
}

+ (ListNode *)rotateRight:(ListNode *)head k:(NSUInteger)k {
    //异常
    if (!head || !head.next || k == 0) {
        return head;
    }
    int count = 1;
    ListNode *tmp = head;
    while (tmp.next) {
        tmp = tmp.next;
        count++;
    }
    NSUInteger moveCount = k % count;
    if (moveCount == 0) {
        return head;
    }
    tmp.next = head;
    //注意是右移断开，所以取补
    moveCount = count-moveCount;
    for (int i = 1; i < moveCount; ++i) {
        head = head.next;
    }
    ListNode *result = head.next;
    head.next = nil;
    return  result;
}

@end
