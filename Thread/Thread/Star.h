//
//  Star.h
//  Thread
//
//  Created by 马鹏 on 2021/7/26.
//

#import <Foundation/Foundation.h>

/**
 *  参数枚举结束符标记，配合 KSTArray 和 KSTDict 使用
 */

static NSString * const KSTStart = @"KSTSTART";
static NSString * const KSTEnd = @"KSTEND";


/**
 *  @brief  数组安全构造函数
 *  @param  combine  是否合并数组。若为YES，obj中的NSArray类型会被拆分，将其元素加入结果集。
 *  @param  obj0  obj0, obj1, ... 数组元素，支持识别空指针，参数以 KSTStart 起始（可选）、KSTEnd 结束。
 *  @return 填充了obj的可变数组，无obj时返回nil。
 */

static inline NSMutableArray * _KSTArray(BOOL combine, id obj0, ...)
{
    if (obj0 == KSTEnd) {
        return nil;
    }
    
    va_list args;
    va_start(args, obj0);
    
    id obj = obj0;
    if (obj == KSTStart) { // 起始标记
        obj = va_arg(args, id);
        
        if (obj == KSTEnd) {
            va_end(args);
            return nil;
        }
    }
    
    NSMutableArray *array = [NSMutableArray array];
    while (obj != KSTEnd) {
        if (obj != nil) {
            if (combine && [obj isKindOfClass:[NSArray class]]) { // 加入数组元素，取代数组对象
                [array addObjectsFromArray:obj];
            } else {
                [array addObject:obj];
            }
        }
        obj = va_arg(args, id);
    }
    
    va_end(args);
    
    return array;
}
#define KSTArray(...) _KSTArray(NO, KSTStart, ##__VA_ARGS__, KSTEnd)


#define KSTLogAMInfo(tagStr, frmt,...)  KSTLog_OBJC_MAYBE(KSTLogLevelInfo, @"mpmodule", KSTArray(tagStr), frmt,##__VA_ARGS__)

#define KSTLog_OBJC_MAYBE(levelEnum, moduleStr, tagArray, frmt,...) \
        KSTLog_MAYBE([Star sharedInstance], levelEnum, moduleStr, tagArray, frmt,##__VA_ARGS__)
#define KSTLog_MAYBE(logger, levelEnum, moduleStr, tagArray, frmt,...) \
        [logger kst_log: levelEnum              \
                 module: moduleStr              \
                   tags: tagArray               \
                   file: __FILE__               \
               function: __PRETTY_FUNCTION__    \
                   line: __LINE__               \
                 format:(frmt), ## __VA_ARGS__]


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, KSTLogLevel) {
    KSTLogLevelUnknown  = 0,
    KSTLogLevelError    = (1 << 0),
    KSTLogLevelWarning  = (1 << 1),
    KSTLogLevelInfo     = (1 << 2),
    KSTLogLevelDebug    = (1 << 3),
};

@interface Star : NSObject

+ (instancetype)sharedInstance;

- (void)kst_log:(KSTLogLevel)level
         module:(NSString *)module
           tags:(NSArray<NSString *> *)tags
           file:(const char *)file
       function:(nullable const char *)function
           line:(NSUInteger)line
         format:(NSString *)format, ... ;


@end

NS_ASSUME_NONNULL_END
