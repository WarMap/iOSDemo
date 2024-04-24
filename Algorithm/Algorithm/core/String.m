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
    NSString *str = @" are  you ok ";
    NSLog(@"%@",[self reverseWords:str]);
}

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

@end

