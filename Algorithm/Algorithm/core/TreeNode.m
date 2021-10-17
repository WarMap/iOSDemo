//
//  TreeNode.m
//  Algorithm
//
//  Created by mapeng on 2021/10/13.
//

#import "TreeNode.h"

@implementation TreeNode

- (NSString *)description
{
    return [NSString stringWithFormat:@"value:%@", self.value];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    TreeNode *node = [[[self class] alloc] init];
    node.left = self.left;
    node.right = self.right;
    node.value = self.value;
    return node;
}

//树节点的值都大于0
+ (instancetype)treeWithArray:(NSArray<NSNumber *> *)array {
    //异常判断
    if (array.count == 0) {
        return nil;
    }
    if (array.firstObject.intValue < 0) {
        return nil;
    }
    
    //特殊case处理
    TreeNode *node = [[TreeNode alloc] init];
    node.value = array.firstObject;
    
    __block NSUInteger i = 1;
    NSMutableArray<TreeNode *> *level = [NSMutableArray arrayWithObject:node];
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
    NSLog(@"root: %@", node);
    return node;
}

@end
