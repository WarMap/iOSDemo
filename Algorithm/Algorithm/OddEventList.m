//
//  OddEventList.m
//  Algorithm
//
//  Created by 马鹏 on 2021/10/20.
//

#import "OddEventList.h"

@implementation OddEventList

+ (void)run {
    int a[] = {1, 2, 3, 4, 5, 6};
    ListNode *result = [self oddEvenList:[ListNode listWithArray:cArray2ocArray(a, 5)]];
    [result output];
}

+ (ListNode *)oddEvenList:(ListNode *)head {
    if (!head) {
        return head;
    }
    ListNode *evenHead = head.next;
    ListNode *tmp = head;
    ListNode *even = evenHead;
    while (even && even.next) {
        tmp.next = even.next;
        tmp = tmp.next;
        even.next = tmp.next;
        even = even.next;
    }
    tmp.next = evenHead;
    return head;
}
@end
