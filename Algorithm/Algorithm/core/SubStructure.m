//
//  SubStructure.m
//  Algorithm
//
//  Created by mapeng on 2021/10/17.
//

#import "SubStructure.h"

@implementation SubStructure

+ (void)run {
    int n[] = {4,1};
    TreeNode *b = [TreeNode treeWithArray:cArray2ocArray(n, 2)];
    int m[] = {3,4,5,1,2};
    TreeNode *a = [TreeNode treeWithArray:cArray2ocArray(m, 5)];
    BOOL flag = [self tree:b isSubStructureOfTree:a];
    NSLog(@"tree b %@ substructure of tree a", flag?@"is":@"isn't");
}
+ (BOOL)tree:(TreeNode *)b isSubStructureOfTree:(TreeNode *)a  {
    if (!b || !a) {
        return false;
    }
    return [self recurTreeNode:b isEqualTreeNode:a] || [self tree:b isSubStructureOfTree:a.left] || [self tree:b isSubStructureOfTree:a.right];
}

+ (BOOL)recurTreeNode:(TreeNode *)b isEqualTreeNode:(TreeNode *)a {
    if (!b) {
        return true;
    }
    if (!a || IV(b.value) != IV(a.value)) {
        return false;
    }
    return [self recurTreeNode:b.left isEqualTreeNode:a.left] && [self recurTreeNode:b.right isEqualTreeNode:a.right];
}
@end
