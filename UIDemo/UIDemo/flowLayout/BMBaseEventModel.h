//
//  BMBaseEventModel.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMBaseEventModel : NSObject

@property (nonatomic, strong) NSString* _Nullable eventName;
@property (nonatomic, strong) id _Nullable parameter;

+ (instancetype)createWithEventName:(NSString* _Nullable)eventName;
+ (instancetype)createWithEventName:(NSString* _Nullable)eventName
                          parameter:(id _Nullable)parameter;


- (instancetype)initWithEventName:(NSString* _Nullable)eventName;
- (instancetype)initWithEventName:(NSString* _Nullable)eventName
                        parameter:(id _Nullable)parameter;



@end

NS_ASSUME_NONNULL_END
