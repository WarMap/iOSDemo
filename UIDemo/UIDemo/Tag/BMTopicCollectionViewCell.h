//
//  BMTopicCollectionViewCell.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/6/19.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMTagModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface BMTopicCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BMTagModel *model;

+ (CGFloat)extWidthWithModel:(BMTagModel *)model;

@end

NS_ASSUME_NONNULL_END
