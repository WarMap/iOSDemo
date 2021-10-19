//
//  SortList.m
//  Algorithm
//
//  Created by mapeng on 2021/10/19.
//

#import "SortList.h"

@implementation SortList

+ (void)run {
    
    int a[] = {1,3,4,5,7,2,6};
    ListNode *node = [[ListNode alloc] initWithArray:cArray2ocArray(a, 7)];
    ListNode *result = [self sortList:node];
    [result output];
}


+ (ListNode *)sortList:(ListNode *)head {
    return [self _sortList:head tail:nil];
}

+ (ListNode *)_sortList:(ListNode *)head tail:(ListNode *)tail {
    if (!head) {
        return nil;
    }
    if (head.next == tail) {
        head.next = nil;
        return head;
    }
    ListNode *slow = head, *fast = head;
    while (fast != tail) {
        slow = slow.next;
        fast = fast.next;
        if (fast != tail) {
            fast = fast.next;
        }
    }
    ListNode *mid = slow;
    return [self merge:[self _sortList:head tail:mid] head2:[self _sortList:mid tail:tail]];
}

+ (ListNode *)merge:(ListNode *)head1 head2:(ListNode *)head2 {
    ListNode *dummy = [[ListNode alloc] initWithValue:0 next:nil];
    ListNode *temp = dummy;
    ListNode *temp1 = head1;
    ListNode *temp2 = head2;
    while (temp1 && temp2) {
        if (temp1.value <= temp2.value) {
            temp.next = temp1;
            temp1 = temp1.next;
        } else {
            temp.next = temp2;
            temp2 = temp2.next;
        }
        temp = temp.next;
    }
    if (temp1) {
        temp.next = temp1;
    } else if (temp2) {
        temp.next = temp2;
    }
    return dummy.next;
}
@end
