//
//  RemoveNthFromEnd.m
//  Algorithm
//
//  Created by mapeng on 2021/10/15.
//

#import "RemoveNthFromEnd.h"

@implementation RemoveNthFromEnd

+ (void)run {
    ListNode *n = [[ListNode alloc] initWithArray:@[@1, @2, @3, @4, @5]];
    n = [self removeNth:2 fromList:n];
    [n output];
}

/// 这里要return head，不然删第一个节点时，入参是不会变的。删后面的没问题
/// @param n <#n description#>
/// @param head <#head description#>
+ (ListNode *)removeNth:(int)n fromList:(ListNode *)head {
    ListNode *result = [[ListNode alloc] initWithValue:-1 next:head];
    ListNode *pointer = head;
    //找到要移除位置的元素，注意是倒数
    while (pointer) {
        pointer = pointer.next;
        n = n - 1;
        if (n < 0) {
            result = result.next;
        }
    }
    //如果是result没有移动则是要删掉头
    if (result.value == -1) {
        head = head.next;
    } else {
        result.next = result.next.next;
    }
    return head;
}
@end
