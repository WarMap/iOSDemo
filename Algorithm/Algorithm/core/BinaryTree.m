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

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *array  = @[@1, @2, @3, @-1, @-1, @4, @5, @6];
        [self treeWithArray:array];
        [self test];
    }
    return self;
}

- (void)test {
    [self levelScan];
}


- (void)treeWithArray:(NSArray<NSNumber *> *)array {
    //异常判断
    if (array.count == 0) {
        return;
    }
    if (array.firstObject.intValue < 0) {
        return;
    }
    
    //特殊case处理
    TreeNode *node = [[TreeNode alloc] init];
    node.value = array.firstObject;
    self.root = node;
    
    __block NSUInteger i = 1;
    NSMutableArray<TreeNode *> *level = [NSMutableArray arrayWithObject:self.root];
    while (i < array.count) {
        NSMutableArray *nextLevel = [NSMutableArray array];

        [level enumerateObjectsUsingBlock:^(TreeNode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (i < array.count) {
                if (array[i].intValue > 0) {
                   TreeNode *node = [[TreeNode alloc] init];
                   node.value = array[i];
                   obj.left = node;
                   [nextLevel addObject:node];
               }
                i++;
            }
            if (i < array.count) {
                if (array[i].intValue > 0) {
                   TreeNode *node = [[TreeNode alloc] init];
                   node.value = array[i];
                   obj.right = node;
                   [nextLevel addObject:node];
               }
                i++;
            }
        }];
        level = nextLevel;
    }
    NSLog(@"root: %@", _root);
}

- (void)levelScan {
    if (!self.root) {
        NSLog(@"has no node");
        return;
    }
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray<TreeNode *> *array = [NSMutableArray arrayWithObject:self.root];
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
    NSLog(@"levelScan--%@", result);
}
@end
