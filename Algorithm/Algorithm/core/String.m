//
//  String.m
//  Algorithm
//
//  Created by 马鹏 on 2024/4/24.
//

#import "String.h"

@implementation String

+ (void)run
{
    [self reverseWord];
}

+ (void)reverseWord
{
//    NSString *originalString = @"  Hello,     World! How are you?   ";
    NSString *inputString = @"ccaabbcb";//@"abcabcbb";
    NSLog(@"%ld",(long)[self lengthOfLongestSubstringTwoDistinct:inputString]);
    NSArray<NSNumber *> *testArray = @[@2, @3, @1, @2, @4, @3];
    NSInteger targetSum = 7;
    NSInteger result = [self minSubArrayLen:targetSum array:testArray];
    NSLog(@"The minimum length of a subarray is %ld", (long)result);
}

// 151 反转单词
+ (NSString *)reverseWords:(NSString *)s {
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray<NSString *> *words = [s componentsSeparatedByCharactersInSet:charSet];
    NSMutableArray<NSString *> *filteredWords = [[NSMutableArray alloc] init];
    
    // 反转数组中的非空字符串
    for (NSString *word in [words reverseObjectEnumerator]) {
        if (word.length > 0) {
            [filteredWords addObject:word];
        }
    }
    
    // 将反转后的单词数组转换为单个字符串
    return [filteredWords componentsJoinedByString:@" "];
}

// 第 3 题，无重复字符的最长子串  滑动窗口(Sliding Window)方法
// 注：找出每一个字符作为最后一个字符的无重复子串的长度，就知道结果了。
// 假定目前最大长度 i到j， j 作为最后一个字符，然后再把 j++的元素放进去，
// 如果 j++位置的元素前面存在， 则和 i 比较下，如果在 i 和 j++之间，则更新下 i
// j++结尾的长度则为 newi 到 j++
+ (NSInteger)lengthOfLongestSubstring:(NSString *)s {
    NSInteger n = [s length];
    NSInteger ans = 0;
    NSMutableDictionary<NSString *, NSNumber *> *indexMap = [NSMutableDictionary dictionary];

    for (NSInteger j = 0, i = 0; j < n; j++) {
        NSString *currentChar = [s substringWithRange:NSMakeRange(j, 1)];
        
        if ([indexMap objectForKey:currentChar] != nil) {
            // 更新左指针 i
            i = MAX([[indexMap objectForKey:currentChar] integerValue] + 1, i);
        }
        
        // 更新最长子串的长度
        ans = MAX(ans, j - i + 1);
        // 存储或更新字符的索引
        [indexMap setObject:@(j) forKey:currentChar];
    }
    
    return ans;
}

+ (NSInteger)lengthOfLongestSubstringTwoDistinct:(NSString *)s {
    NSMutableDictionary *map = [NSMutableDictionary dictionaryWithCapacity:3];
    NSInteger start = 0, maxLength = 0;
    for (NSInteger end = 0; end < s.length; end++) {
        map[[s substringWithRange:NSMakeRange(end, 1)]] = @(end);
        if (map.count > 2) {
            NSInteger delIndex = NSIntegerMax;
            for (NSNumber *value in [map allValues]) {
                delIndex = MIN(delIndex, value.integerValue);
            }
            [map removeObjectForKey:[s substringWithRange:NSMakeRange(delIndex, 1)]];
            start = delIndex + 1;
        }
        maxLength = MAX(maxLength, end - start + 1);
    }
    return maxLength;
}

// 方法实现
+ (NSInteger)minSubArrayLen:(NSInteger)s array:(NSArray<NSNumber *> *)nums {
    NSInteger n = nums.count;
    NSInteger start = 0, sum = 0, minLength = NSIntegerMax;
    for (NSInteger end = 0; end < n; end++) {
        sum += nums[end].integerValue;
        while (sum >= s) {
            minLength = MIN(minLength, end - start + 1);
            sum -= nums[start].integerValue;
            start++;
        }
    }
    return minLength == NSIntegerMax ? 0 : minLength;
}


@end

