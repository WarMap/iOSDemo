//
//  MPThreadUtil.h
//  Thread
//
//  Created by 马鹏 on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import <string.h>


FOUNDATION_EXTERN inline void currentThreadInfo(NSString *str);
FOUNDATION_EXTERN inline void dumpThreads(void);

@interface MPThreadUtil : NSObject
@end


