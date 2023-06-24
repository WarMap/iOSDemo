//
//  BMTagModel.m
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/6/20.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import "BMTagModel.h"

@implementation BMTagModel

- (BOOL)hasHotImage
{
    return [self.isHotTopic isEqualToString:@"1"];
}


@end
