//
//  MPThreadUtil.h
//  Thread
//
//  Created by 马鹏 on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import <string.h>

//同时有.mm和.m文件引用，注意使用FOUNDATION_EXTERN而不是extern
FOUNDATION_EXTERN inline void currentThreadInfo(NSString *str);
FOUNDATION_EXTERN inline void dumpThreads(void);

@interface MPThreadUtil : NSObject
@end


