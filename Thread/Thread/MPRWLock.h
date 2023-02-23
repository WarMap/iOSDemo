//
//  MPRWLock.h
//  Thread
//
//  Created by 马鹏 on 2023/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPRWLock : NSObject

- (void)readLock;
- (void)readUnlock;
- (void)writeLock;
- (void)writeUnlock;

@end

NS_ASSUME_NONNULL_END
