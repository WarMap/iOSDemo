//
//  RemoveNthFromEnd.m
//  Algorithm
//
//  Created by mapeng on 2021/10/15.
//

#import "RemoveNthFromEnd.h"

@implementation RemoveNthFromEnd

+ (void)run {
    int a[] = {1,2,3,4,5,6,7};
    ListNode *n = [[ListNode alloc] initWithArray:cArray2ocArray(a,7)];
    n = [self removeNth:1 fromList:n];
    [n output];
}

+ (ListNode *)removeNth:(int)n fromList:(ListNode *)head {
    ListNode *dummy = [ListNode nodeWithValue:0 next:head];
    ListNode *point = dummy;
    for (int i = 1 ; i < n; ++i) {
        point = point.next;
    }
    ListNode *target = dummy;
    ListNode *pre = target;
    while (point.next) {
        pre = target;
        point = point.next;
        target = target.next;
    }
    NSLog(@"delete %@", target);
    pre.next = target.next;
    return dummy.next;
}
@end
