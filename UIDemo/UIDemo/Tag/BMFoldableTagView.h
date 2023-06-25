//
//  BMFoldableTagView.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/25.
//

#import <UIKit/UIKit.h>
#import "BMTagModel.h"
#import "BMSelectedTagContainer.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFoldableTagView : UIView

@property (nonatomic, strong) BMTagModel *model;
@property (nonatomic, weak) id<BMSelectedTagContainerDelegate> delegate;
+ (CGFloat)defaultHeight;

@end

NS_ASSUME_NONNULL_END
