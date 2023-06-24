//
//  BMTagModel.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/6/20.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMTagModel : NSObject

@property (nonatomic, copy) NSString *topicId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *viewPv;
@property (nonatomic, copy) NSString *isHotTopic;

- (BOOL)hasHotImage;

@end

NS_ASSUME_NONNULL_END
