//
//  NSMutableDictionary+utils.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary<KeyType, ObjectType> (utils)

- (void)setObjectOrNil_ap:(ObjectType _Nullable)anObject forKey:(KeyType <NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END
