//
//  Parentheses.m
//  Algorithm
//
//  Created by 马鹏 on 2023/2/6.
//

#import "Parentheses.h"

@implementation Parentheses

//https://leetcode.cn/problems/valid-parentheses/
+(void)run {
    NSString *s = @"(()[]{})";
    NSMutableArray<NSString *> *res = [NSMutableArray array];
    for(NSUInteger i=0; i<s.length; ++i) {
        unichar c = [s characterAtIndex:i];
        if (c == '(' || c == '[' || c == '{') {
            [res addObject:[NSString stringWithCharacters:&c length:1]];
        } else {
            if ((c == ')' && [res.lastObject characterAtIndex:0] == '(') ||
                (c == ']' && [res.lastObject characterAtIndex:0] == '[') ||
                (c == '}' && [res.lastObject characterAtIndex:0] == '{')) {
                [res removeLastObject];
            } else {
                NSLog(@"bu dui");
            }
        }
    }
    if (res.count == 0) {
        NSLog(@"dui");
    } else {
        NSLog(@"bu dui");
    }
}



@end
