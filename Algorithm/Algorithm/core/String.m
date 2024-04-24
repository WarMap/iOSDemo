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
    NSString *inputString = @"abcabcbb";
    NSLog(@"%ld",(long)[self lengthOfLongestSubstring:inputString]);
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

@end

