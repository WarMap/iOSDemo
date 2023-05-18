//
//  BMInputAnimater.m
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/17.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import "BMInputAnimater.h"


@interface BMInputAnimater ()

@property (nonatomic, strong) NSHashTable<id<BMInputAnimater>> *animater;

@end

@implementation BMInputAnimater

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animater = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addAnimater:(id<BMInputAnimater>)animater
{
    if (animater && ![self.animater containsObject:animater]) {
        [self.animater addObject:animater];
    }
}


- (void)animateWithOldHeight:(CGFloat)oldHeight newHeight:(CGFloat)newHeight
{
    [UIView animateWithDuration:0.2 animations:^{
        for (id<BMInputAnimater> animater in self.animater) {
            [animater animateWithOldHeight:oldHeight newHeight:newHeight];
        }
    }];
}
@end
