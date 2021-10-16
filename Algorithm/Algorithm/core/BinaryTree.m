//
//  BinaryTree.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/6.
//

#import "BinaryTree.h"

@implementation BinaryTree
//          5
//       4     6
//      1 2   7 8


//pre  5 4 1 2 6 7 8
//in   1 4 2 5 7 6 8
//post 1 2 4 7 8 6 5
+ (void)run {
    int arr[] = {5,4,6,1,2,7,8};
    TreeNode *root = [TreeNode treeWithArray:cArray2ocArray(arr, 7)];
//    NSArray<TreeNode *> *nodes = [self _inorderScan:root];
//    NSLog(@"levelScan--%@", nodes);
    NSArray<NSArray *> *result = [self zigzagLevelScan:root];
        NSLog(@"levelScan--%@", result);
}
//层级遍历
+ (NSArray<TreeNode *> *)levelScan:(TreeNode *)root {
    if (!root) {
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

+ (NSArray<NSArray *> *)zigzagLevelScan:(TreeNode *)root {
    if (!root) {
        NSLog(@"has no node");
        return nil;
    }
    NSMutableArray<NSArray *> *result = [NSMutableArray array];
    NSMutableArray<TreeNode *> *level = [NSMutableArray array];
    [level addObject:root];
    BOOL reverse = true;
    while (level.count > 0) {
        if (reverse) {
            [result addObject:level];
        } else {
            [result addObject:[level reverseObjectEnumerator].allObjects];
        }
        NSMutableArray<TreeNode *> *nextLevel = [NSMutableArray array];
        for (TreeNode *node in level) {
            if (node.left) {
                [nextLevel addObject:node.left];
            }
            if (node.right) {
                [nextLevel addObject:node.right];
            }
        }
        reverse = !reverse;
        level = nextLevel;
    }
    return result;
}


+ (NSArray<TreeNode *> *)depthScan:(TreeNode *)root {
    if (root) {
        NSLog(@"has no node");
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    [self _preorderScan:root res:array];
    return array;
}
//前序遍历
+ (void)_preorderScan:(TreeNode *)root res:(NSMutableArray<TreeNode *> *)res {
    if (!root) {
        return;
    }
    [res addObject:root];
    [self _preorderScan:root.left res:res];
    [self _preorderScan:root.right res:res];
}

+ (NSArray<TreeNode *> *)_preorderScan:(TreeNode *)root {
    NSMutableArray<TreeNode *> *stack = [NSMutableArray array];
    NSMutableArray<TreeNode *> *result = [NSMutableArray array];
    [stack addObject:root];
    while (stack.count > 0) {
        TreeNode *node = stack.lastObject;
        [result addObject:node];
        [stack removeLastObject];
        if (node.right) {
            [stack addObject:node.right];
        }
        if (node.left) {
            [stack addObject:node.left];
        }
    }
    return result;
}
//中序遍历 左中右
+ (void)_inorderScan:(TreeNode *)root res:(NSMutableArray<TreeNode *> *)res {
    if (!root) {
        return;
    }
    [self _inorderScan:root.left res:res];
    [res addObject:root];
    [self _inorderScan:root.right res:res];
}

+ (NSArray<TreeNode *> *)_inorderScan:(TreeNode *)root {
    NSMutableArray<TreeNode *> *stack = [NSMutableArray array];
    NSMutableArray<TreeNode *> *result = [NSMutableArray array];
    while (root || stack.count>0) {
        //一直遍历到最左侧
        if (root) {
            [stack addObject:root];
            root = root.left;
        } else {
//          这是最左侧，当左侧取完下次的左侧也就是中间的，也就符合了左中右
            root = stack.lastObject;
            [stack removeLastObject];
            [result addObject:root];
//            在往栈里压右侧
            root = root.right;
        }
    }
    return result;
}
//后序遍历 左右中 （前序时中左右，类似写法搞成中右左，然后在反转）
+ (void)_postorderScan:(TreeNode *)root res:(NSMutableArray<TreeNode *> *)res {
    if (!root) {
        return;
    }
    [self _postorderScan:root.left res:res];
    [self _postorderScan:root.right res:res];
    [res addObject:root];
}
//（前序时中左右，类似写法搞成中右左，然后在反转）
+ (NSArray<TreeNode *> *)_postorderScan:(TreeNode *)root {
    NSMutableArray<TreeNode *> *stack = [NSMutableArray array];
    NSMutableArray<TreeNode *> *result = [NSMutableArray array];
    [stack addObject:root];
    while (stack.count > 0) {
        TreeNode *node = stack.lastObject;
        [result addObject:node];
        [stack removeLastObject];
        if (node.left) {
            [stack addObject:node.left];
        }
        if (node.right) {
            [stack addObject:node.right];
        }
    }
    return [result reverseObjectEnumerator].allObjects;
}
@end
