//
//  ValidBST.m
//  Algorithm
//
//  Created by mapeng on 2021/10/16.
//

#import "ValidBST.h"

@implementation ValidBST

+ (void)run {
    int arr[] = {5,4,6,1,2,7,8};
    TreeNode *root = [TreeNode treeWithArray:cArray2ocArray(arr, 7)];
    BOOL flag = [self isValidBST:root];
    NSLog(@"it %@ a valid BST", flag?@"is": @"isn't" );
}

+ (BOOL)isValidBST:(TreeNode *)root {
    int k = INT_MIN;
    NSMutableArray<TreeNode *> *stack = [NSMutableArray array];
    while (root || stack.count > 0) {
        if (root) {
            [stack addObject:root];
            root = root.left;
        } else {
            TreeNode *node = stack.lastObject;
            if (k >= node.value.intValue) {
                return NO;
            }
            k = IV(node.value);
            NSLog(@"scan: %@", node.value);
            [stack removeLastObject];
            root = node.right;
        }
    }
    return YES;
}
@end
