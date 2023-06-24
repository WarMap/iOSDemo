//
//  NSMutableArray+utils.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (utils)

- (void)addObjectOrNil:(id)obj;
- (id)objectOrNilAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
