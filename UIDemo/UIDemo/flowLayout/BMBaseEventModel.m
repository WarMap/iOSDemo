//
//  BMBaseEventModel.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import "BMBaseEventModel.h"

@implementation BMBaseEventModel

- (instancetype)initWithEventName:(NSString* _Nullable)eventName {
    return [self initWithEventName:eventName parameter:nil];
}

- (instancetype)initWithEventName:(NSString* _Nullable)eventName parameter:(id _Nullable)parameter {
    if (self == [super init]) {
        self.eventName = eventName;
        self.parameter = parameter;
    }
    return self;
}

+ (instancetype)createWithEventName:(NSString* _Nullable)eventName {
    BMBaseEventModel* eventModel = [[BMBaseEventModel alloc] initWithEventName:eventName
                                                                     parameter:nil];
    return eventModel;
}

+ (instancetype)createWithEventName:(NSString* _Nullable)eventName parameter:(id _Nullable)parameter {
    BMBaseEventModel* eventModel = [[BMBaseEventModel alloc] initWithEventName:eventName
                                                                     parameter:parameter];
    return eventModel;
}


@end
