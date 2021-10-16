//
//  BinaryTree.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/6.
//

#import "BinaryTree.h"

@interface BinaryTree ()

@property (nonatomic, strong) TreeNode *root;

@end

@implementation BinaryTree

+ (void)run {
    NSArray *array  = @[@1, @2, @3, @-1, @-1, @4, @5, @6];
    TreeNode *root = [TreeNode treeWithArray:array];
    NSArray<TreeNode *> *nodes = [self levelScan:root];
    NSLog(@"levelScan--%@", nodes);
}
//层级遍历
+ (NSArray<TreeNode *> *)levelScan:(TreeNode *)root {
    if (root) {
        NSLog(@"has no node");
        return nil;
    }
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray<TreeNode *> *array = [NSMutableArray arrayWithObject:root];
    while (array.count > 0) {
        NSMutableArray<TreeNode *> *nextLevel = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(TreeNode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [result addObject:obj];
            if (obj.left) {
                [nextLevel addObject:obj.left];
            }
            if (obj.right) {
                [nextLevel addObject:obj.right];
            }
        }];
        array = nextLevel;
    }
    return result;
}
//前序遍历

+ (NSArray<TreeNode *> *)depthScan:(TreeNode *)root {
    if (root) {
        NSLog(@"has no node");
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    [self _preorderScan:root res:array];
    return array;
}

+ (void)_preorderScan:(TreeNode *)root res:(NSMutableArray<TreeNode *> *)res {
    if (!root) {
        return;
    }
    [res addObject:root];
    [self _preorderScan:root.left res:res];
    [self _preorderScan:root.right res:res];
}
//中序遍历
+ (void)_inorderScan:(TreeNode *)root res:(NSMutableArray<TreeNode *> *)res {
    if (!root) {
        return;
    }
    [self _inorderScan:root.left res:res];
    [res addObject:root];
    [self _inorderScan:root.right res:res];
}
//后序遍历
+ (void)_postorderScan:(TreeNode *)root res:(NSMutableArray<TreeNode *> *)res {
    if (!root) {
        return;
    }
    [self _postorderScan:root.left res:res];
    [self _postorderScan:root.right res:res];
    [res addObject:root];
}
@end
