//
//  LargestLevelValue.m
//  Algorithm
//
//  Created by mapeng on 2021/10/17.
//

#import "LargestLevelValue.h"

@implementation LargestLevelValue

+ (void)run {
    int a[] = {1, 3, 2, 5, 3, 0, 9};
//    int a[] = {1, 0, 9};
//    NSArray *result = [self largestValue:[TreeNode treeWithArray:cArray2ocArray(a, 3)]];
    int result = [self findBottomLeftValue:[TreeNode treeWithArray:cArray2ocArray(a, 7)]];
    NSLog(@"largest level value: %d" , result);
}

+ (NSArray<NSNumber *> *)largestValue:(TreeNode *)root {
    if (!root) {
        return @[];
    }
    NSMutableArray<NSNumber *> *result = [NSMutableArray array];
    NSMutableArray<TreeNode *> *level = [NSMutableArray array];
    [level addObject:root];
    while (level.count > 0) {
        NSMutableArray<TreeNode *> *nextLevel = [NSMutableArray array];
        __block int curLevelLargest = INT_MIN;
        [level enumerateObjectsUsingBlock:^(TreeNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (IV(obj.value) > curLevelLargest) {
                curLevelLargest = IV(obj.value);
            }
            if (obj.left) {
                [nextLevel addObject:obj.left];
            }
            if (obj.right) {
                [nextLevel addObject:obj.right];
            }
        }];
        [result addObject:@(curLevelLargest)];
        level = nextLevel;
    }
    return result;
}


+ (int)findBottomLeftValue:(TreeNode *)root {
    if (!root) {
        return INT_MIN;
    }
    int result = INT_MIN;
    NSMutableArray<TreeNode *> *level = [NSMutableArray array];
    [level addObject:root];
    while (level.count > 0) {
        result = IV(level.firstObject.value);
        NSUInteger count = level.count;
        for (int i = 0; i<count; ++i) {
            if (level[0].left) {
                [level addObject:level[0].left];
            }
            if (level[0].right) {
                [level addObject:level[0].right];
            }
            [level removeObjectAtIndex:0];
        }
    }
    return result;
}
@end
