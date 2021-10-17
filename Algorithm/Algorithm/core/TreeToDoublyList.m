//
//  TreeToDoublyList.m
//  Algorithm
//
//  Created by mapeng on 2021/10/17.
//

#import "TreeToDoublyList.h"

@implementation TreeToDoublyList

+ (void)run {
    int a[] = {2, 1, 3};
    TreeNode *result = [self TreeToDoublyList:[TreeNode treeWithArray:cArray2ocArray(a, 3)]];
    NSLog(@"doubly list: %@", result);
}

+ (TreeNode *)TreeToDoublyList:(TreeNode *)node {
    if (!node) {
        return nil;
    }
    [self dfs:node];
    pre.right = head;
    head.left = pre;
    return head;
}

static TreeNode *pre;
static TreeNode *head;

+ (void)dfs:(TreeNode *)node {
    if (!node) {
        return;
    }
    [self dfs:node.left];
    if (pre) {
        pre.right = node;
    } else {
        head = node;
    }
    node.left = pre;
    pre = node;
    [self dfs:node.right];
}
@end
