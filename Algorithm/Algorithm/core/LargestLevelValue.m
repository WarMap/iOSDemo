//
//  LargestLevelValue.m
//  Algorithm
//
//  Created by mapeng on 2021/10/17.
//

#import "LargestLevelValue.h"

@implementation LargestLevelValue

+ (void)run {
//    int a[] = {1, 3, 2, 5, 3, 0, 9};
    int a[] = {1, 0, 9};
    NSArray *result = [self largestValue:[TreeNode treeWithArray:cArray2ocArray(a, 3)]];
    NSLog(@"largest level value: %@" , result);
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
@end
