//
//  ValidBST.m
//  Algorithm
//
//  Created by mapeng on 2021/10/16.
//
//    3
//  /  \
// 9   20
//     /  \
//    15   7
#import "ValidBST.h"

@implementation ValidBST

+ (void)run {
    int arr[] = {3,9,20,0,0,15,7};
    TreeNode *root = [TreeNode treeWithArray:cArray2ocArray(arr, 7)];
    BOOL flag = [self isBalanced:root];
    NSLog(@"it %@ a valid BST", flag?@"is": @"isn't" );
}
//https://leetcode.cn/problems/ping-heng-er-cha-shu-lcof/
+ (BOOL)isBalanced:(TreeNode *)root {
    if (!root) return true;
    return [self recur:root] != -1;
}

+ (int)recur:(TreeNode *)node {
    if (!node) return 0;
    int left = [self recur:node.left];
    if (left == -1) return -1;
    int right = [self recur:node.right];
    if (right == -1) return -1;
    return abs(left-right)<2 ? MAX(left, right)+1 : -1;
}
//https://leetcode.cn/problems/validate-binary-search-tree/
//搜索二叉树
+ (BOOL)isValidBST:(TreeNode *)root {
    int k = INT_MIN;
    NSMutableArray<TreeNode *> *stack = [NSMutableArray array];
    while (root || stack.count > 0) {
        if (root) {
            [stack addObject:root];
            root = root.left;
        } else {
//            1.取节点
            TreeNode *node = stack.lastObject;
//            2.对应操作
            if (k >= node.value.intValue) {
                return NO;
            }
            k = IV(node.value);
            NSLog(@"scan: %@", node.value);
//            3.删节点
            [stack removeLastObject];
//            4.递归下去
            root = node.right;
        }
    }
    return YES;
}
@end
