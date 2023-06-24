//
//  NSMutableArray+utils.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/21.
//

#import "NSMutableArray+utils.h"

@implementation NSMutableArray (utils)


- (void)addObjectOrNil:(id)obj {
    if (obj) {
        [self addObject:obj];
    }
}

- (id)objectOrNilAtIndex:(NSInteger)index {
    if (index >= 0 && index<self.count){
        return [self objectAtIndex:index];
    }
    return nil;
}
@end

