//
//  NSMutableDictionary+utils.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/21.
//

#import "NSMutableDictionary+utils.h"

@interface NSMutableDictionary<KeyType, ObjectType> (utils)

@end

@implementation NSMutableDictionary (utils)

- (void)setObjectOrNil_ap:(id _Nullable)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject || !aKey) {
        return;
    }
    [self setObject:anObject forKey:aKey];
}


@end
