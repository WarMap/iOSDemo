//
//  BMSelectedTagContainer.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/24.
//

#import <UIKit/UIKit.h>
#import "BMTagModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BMSelectedTagContainer;

@protocol BMSelectedTagContainerDelegate <NSObject>

- (void)selectedTagContainerDeseleted:(BMSelectedTagContainer *)container;

@end

@interface BMSelectedTagContainer : UIView

@property (nonatomic, strong) BMTagModel *model;
@property (nonatomic, weak) id<BMSelectedTagContainerDelegate> delegate;
+ (CGFloat)defaultHeight;

@end

NS_ASSUME_NONNULL_END
