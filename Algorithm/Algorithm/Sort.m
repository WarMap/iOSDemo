//
//  Sort.m
//  Algorithm
//
//  Created by mapeng on 2021/10/15.
//

#import "Sort.h"

@implementation Sort

+ (void)run
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@(1), @(2), @(3), nil];
    [self swapArray:array indexA:0 indexB:2];
    NSLog(@"array: %@", array);
}

+ (NSArray<NSNumber *> *)bubbleSort:(NSArray<NSNumber *> *)array
{
    NSMutableArray *arr = [array mutableCopy];
    for (int i = 0; i < [arr count]; i++) {
        for (int j = 0; j < [arr count] - 1 - i; j++) {
            if ([arr[j] integerValue] > [arr[j + 1] integerValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return [arr copy];
}

+ (void)swapArray:(NSMutableArray<NSNumber *> *)array indexA:(NSUInteger)indexA indexB:(NSUInteger)indexB
{
    if (indexA>=array.count || indexB>=array.count || indexA==indexB) return;
    if (array[indexA] == array[indexB]) return;
    
    NSNumber *tmp = array[indexA];
    array[indexA] = array[indexB];
    array[indexB] = tmp;
    
//    array[indexA] = @([array[indexA] integerValue] ^ [array[indexB] integerValue]);
//    array[indexB] = @([array[indexA] integerValue] ^ [array[indexB] integerValue]);
//    array[indexA] = @([array[indexA] integerValue] ^ [array[indexB] integerValue]);

}

+ (NSArray<NSNumber *> *)me:(NSArray<NSNumber *> *)ar
{
    if (ar.count < 2) return  ar;
    
    NSUInteger c = ar.count/2;
    
    NSArray *a = [ar subarrayWithRange:NSMakeRange(0, c)];
    NSArray *b = [ar subarrayWithRange:NSMakeRange(c, ar.count-c)];
    
    a = [self mergeSort:a];
    b = [self mergeSort:b];
    
    return [self merge:a with:b];
}

+ (NSArray<NSNumber *> *)mergeSort:(NSArray<NSNumber *> *)array {
    // 如果数组只有一个元素，则已经排序
    if ([array count] < 2) {
        return array;
    }
    
    // 找到中间索引
    NSInteger middle = [array count] / 2;
    
    // 拆分数组为左半和右半
    NSArray *leftArray = [array subarrayWithRange:NSMakeRange(0, middle)];
    NSArray *rightArray = [array subarrayWithRange:NSMakeRange(middle, [array count] - middle)];
    
    // 递归调用 mergeSort 来继续拆分数组，直到只剩一个元素
    leftArray = [self mergeSort:leftArray];
    rightArray = [self mergeSort:rightArray];
    
    // 合并两个排序好的子数组
    return [self merge:leftArray with:rightArray];
}

// 辅助函数：合并两个已排序的数组
+ (NSArray<NSNumber *> *)merge:(NSArray<NSNumber *> *)left
                          with:(NSArray<NSNumber *> *)right
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[left count] + [right count]];
    int leftIndex = 0, rightIndex = 0;
    
    // 遍历左右两个数组，按顺序选择较小的元素放入结果数组中
    while (leftIndex < [left count] && rightIndex < [right count]) {
        if ([left[leftIndex] intValue] <= [right[rightIndex] intValue]) {
            [result addObject:left[leftIndex++]];
        } else {
            [result addObject:right[rightIndex++]];
        }
    }
    
    // 如果左边数组仍有剩余，将剩余部分添加到结果数组
    while (leftIndex < [left count]) {
        [result addObject:left[leftIndex++]];
    }
    
    // 同样，如果右边数组仍有剩余，将剩余部分添加到结果数组
    while (rightIndex < [right count]) {
        [result addObject:right[rightIndex++]];
    }
    
    return result;
}

@end
