//
//  TwoSum.m
//  Algorithm
//
//  Created by mapeng on 2021/10/13.
//

#import "TwoSum.h"



@interface TwoSum ()

@end

@implementation TwoSum

+ (void)run {
    ListNode *node1 = [[ListNode alloc] initWithArray:@[@9,@9,@9,@9,@9,@9,@9]];
    ListNode *node2 = [[ListNode alloc] initWithArray:@[@9,@9,@9,@9]];
    ListNode *result = [self addNumber:node1 to:node2];
    [result output];
}

+ (ListNode *)addNumber:(ListNode *)node1 to:(ListNode *)node2 {
    ListNode *result = [[ListNode alloc] initWithValue:-1 next:nil];
    ListNode *tmp = result;
    int sum = 0;
    BOOL carry = false;
    while (node1 || node2) {
        sum = 0;
        if (node1) {
            sum+=node1.value;
            node1 = node1.next;
        }
        if (node2) {
            sum+= node2.value;
            node2 = node2.next;
        }
        if (carry) {
            sum++;
        }
        tmp.next = [[ListNode alloc] initWithValue:sum%10 next:nil];
        tmp = tmp.next;
        carry=sum>=10;
    }
    if (carry) {
        tmp.next = [[ListNode alloc] initWithValue:1 next:nil];
    }
    return result.next;
}

//class Solution {
//public:
//    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
//        ListNode* head=new ListNode(-1);//存放结果的链表
//        ListNode* h=head;//移动指针
//        int sum=0;//每个位的加和结果
//        bool carry=false;//进位标志
//        while(l1!=NULL||l2!=NULL)
//        {
//            sum=0;
//            if(l1!=NULL)
//            {
//                sum+=l1->val;
//                l1=l1->next;
//            }
//            if(l2!=NULL)
//            {
//                sum+=l2->val;
//                l2=l2->next;
//            }
//            if(carry)
//                sum++;
//            h->next=new ListNode(sum%10);
//            h=h->next;
//            carry=sum>=10?true:false;
//        }
//        if(carry)
//        {
//            h->next=new ListNode(1);
//        }
//        return head->next;
//    }
//};

@end
